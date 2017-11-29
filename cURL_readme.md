# USING cURL to querry the web service 

## 1. To create the Company with cURL, execute curl with following options:

	-i	  - include the HTTP header in the output (date, HTTP version...)

	-d <data> - sends specific data with POST request 

	-X <command> - specifies the custom request (we used POST)

	-H <header>  - setting the header to "Content-Type: application/json"

curl -i -X POST -H "Content-Type: application/json" -d'{"id":"The ID of the Company", "name":"The name of the Company", "address":"address", "city":"city where the company is", "country":"country of the Company", "email":"email", "telephone":"phonenumber","directors":"directors"}' http://localhost:4567/api/v1/companies


## 2. To update the company with Curl,we use use the same options but different request. To update data, we need to use PATCH request while specifying the correct id of the company we would like to update:

	-NOTE: In the URL id needs to be specified as well http://PATH/id

curl -i -X PATCH -H "Content-Type: application/json" -d '{"id":"3","name":"new name"}' http://localhost:4567/api/v1/companies/3



## 3. To PREVIEW the company with cURL, execute cURL with GET request similar like with POST, just specigy the ID of the company (example,ID=3) in the url like this:

curl - i -X GET -H "Content-Type: application/json" http://localhost:4567/api/v1/3


## 4. To delete the company, it is needed to execute cURl with the request DELETE, while in the URL defining the id of the company we want to delete:

curl - i -X DELETE -H "Content-Type: application/json" http://localhost:4567/api/v1/3


source: https://www.computerhope.com/unix/curl.htm
