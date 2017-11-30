var app = angular.module('myApp', ["ngRoute"]);
app.controller('customersCtrl', function($scope, $http) {
	  $scope.company=[];
	  $http.get("https://thawing-ridge-85057.herokuapp.com/api/v1/companies")
    .then(function(response) {
    	$scope.company = response.data;
    	
       	    
    });
        
   
	});
	
app.config(function($routeProvider) {
    $routeProvider
    .when("localhost/", {
        templateUrl : "index.html",
        controller  : "mainCtrl"        
    })
    .when("/red", {
        templateUrl : "red.htm",
        controller  : "redCtrl"       
    })
    .when("/green", {
        templateUrl : "green.htm",
        controller  : "formCtrl"
    })
    .when("/blue", {
        templateUrl : "blue.htm",
        controller  : "blueCtrl"
    });
});

app.controller("mainCtrl", function ($scope) {
    $scope.msg = "This is Home";
});

app.controller("redCtrl", function ($scope) {
    $scope.msg = "All companies are listed here";
});

/*app.controller("greenCtrl", function ($scope) {
    $scope.msg = "I love London";
});*/

app.controller("blueCtrl", function ($scope) {
    $scope.msg = "I love Paris";
});



app.controller('formCtrl', function($scope, $http) {
			$scope.formData = {};
			$scope.processForm = function() {
				$http({
			        method  : 'POST',
			        url     : 'https://thawing-ridge-85057.herokuapp.com/api/v1/companies',
			        data    : $scope.formData,  // pass in data as strings
			        headers : { 'Content-Type': 'application/x-www-form-urlencoded'}
			    })
			        .success(function(response) {
			        var data = response.data;
			           console.log(data);
			            if (!data.success) {
			            	// if not successful, bind errors to error variables
			                $scope.errorName = data.errors.name;
			                $scope.errorSuperhero = data.errors.superheroAlias;
			            } else {
			            	// if successful, bind success message to message
			                $scope.message = data.message;
                                        $scope.errorName = '';
			                $scope.errorSuperhero = '';
			            }
			        });
			}

		});
