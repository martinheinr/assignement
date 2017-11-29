#server.rb
require 'sinatra'
require 'mongoid'
require 'sinatra/namespace'
require 'sinatra/base'
require 'json'
require 'sinatra/json'
require 'uri'


options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS,PATCH"

# Needed for AngularJS
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

end


before do
   headers 'Access-Control-Allow-Origin' => '*', 
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PATCH', 'PUT']  
end

#load database config
Mongoid.load! "mongoid.config"

#Class Company 
class Company
  include Mongoid::Document
  

#  field :id, type: String
  field :name, type: String
  field :address, type: String
  field :city, type: String
  field :country, type: String
  field :email, type: String
  field :telephone, type: String
  field :directors, type: String
#  field :benificialowner, type: String

#  validates :id, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
#  validates :email, presence: true
#  validates :telephone, presence: true
  validates :directors, presence: true
#  validates :benificialowner, presence: true

  index({ id:1 }, { unique: true, name: "id_index" })

  scope :name, -> (name) { where(name: /^#{name}/) } # this could be changed to /^#{title}/i to make case insensitive searcg =end
  scope :id, -> (id) { where(id: id) }
end

#Serializers

class Serializer
  def initialize(company)
    @company = company
  end

  def as_json(*)
    data = {
      id:@company.id.to_s,
#      compid:@company.compid,
      name:@company.name,
      address:@company.address,
      city:@company.city,
      country:@company.country,
      email:@company.email,
      telephone:@company.telephone,
      directors:@company.directors,
#      benificialowner:@company.benificialowner,
    }
    data[:errors] = @company.errors if@company.errors.any?
    data
  end
end

# Endpoints

get '/' do  
   'List of all Companies'
end

namespace '/api/v1' do

  before do
    content_type 'application/json'
  end

  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
    end

  def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message:'Invalid JSON' }.to_json
      end
    end
  end

get '/companies' do
    companies = Company.all

    [ :id, :name, :address, :city, :country, :telephone, :directors, :email].each do |filter|
       companies = companies.send(filter, params[filter]) if params[filter]
  end

	companies.map { |company| Serializer.new(company) }.to_json #put it through the serializer not to get all te atributes
  end

get '/companies/:id' do |id|	#get the details about the company by searching with compid
    company = Company.where(id: id).first
    halt(404, { message:'Company Not Found'}.to_json) unless company 
    Serializer.new(company).to_json

  end  

post '/companies' do
    company = Company.new(json_params)
    if   company.save
#      response.headers['Location'] = "#{base_url}/api/v1/companies{company.id}" 
      status 201
    else
      status 422
      body Serializer.new(company).to_json
    end
 end

patch '/companies/:id' do |id|
    company = Company.where(id: id).first
    halt(404, { message:'Company Not Found'}.to_json) unless company
    if company.update_attributes(json_params)
      Serializer.new(company).to_json
    else
      status 422
      body Serializer.new(company).to_json
    end
  end

delete '/companies/:id' do |id|
    company = Company.where(id: id).first
    company.destroy if company
    status 204
  end
end
