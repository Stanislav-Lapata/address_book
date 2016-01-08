
var app = angular.module('AddressBook', ['ngResource']);

app.factory('Person', ['$resource', function($resource){
  return $resource('/people/:id', {id: '@id'}, {update: {method: 'PUT'}})
}]);

app.factory('EmailAddress', ['$resource', function($resource){
  return $resource('/email_addresses/:id', {id: '@id'}, {update: {method: 'PUT'}})
}]);

app.factory('PhoneNumber', ['$resource', function($resource){
  return $resource('/phone_numbers/:id', {id: '@id'}, {update: {method: 'PUT'}})
}]);

app.controller('PeopleCtrl', ['$scope', 'Person', 'EmailAddress', 'PhoneNumber', function($scope, Person, EmailAddress, PhoneNumber){
  $scope.people = Person.query();
  $scope.addOrEdit = "Add person"
  $scope.newPerson = {email_addresses_attributes: [{email: "", _destroy:""}], phone_numbers_attributes: [{phone_number: "", _destroy:""}]};
  $scope.addPerson = function () {
    if ($scope.newPerson.id) {
      Person.update($scope.newPerson).$promise.then(function (response) {
        if (response.id) {
        $scope.newPerson.phone_numbers_attributes = response.phone_numbers_attributes
        $scope.newPerson.email_addresses_attributes = response.email_addresses_attributes
        $scope.errors = {errors: ""};
        $scope.newPerson = {email_addresses_attributes: [{email: ""}], phone_numbers_attributes: [{phone_number: ""}]};
        $scope.addOrEdit = "Add person"
        }
        else
        {
          $scope.errors = response;
        }
      });
    }
    else {
      person = Person.save($scope.newPerson).$promise.then(function (response) {
        if (response.id)
          {
            $scope.people.push(response);
            $scope.newPerson = {email_addresses_attributes: [{email: ""}], phone_numbers_attributes: [{phone_number: ""}]}
            $scope.errors = {errors: ""};
          }
        else
          {
            $scope.errors = response;
          }
      });
    };
  };
  $scope.personShowed = false;
  $scope.showPerson = function(person) {
    $scope.personShowed = true;
    $scope.firstName = person.first_name;
    $scope.lastName = person.last_name;
    $scope.emails = person.email_addresses_attributes;
    $scope.phoneNumbers = person.phone_numbers_attributes;
  };
  $scope.showPeople = function() {
    $scope.personShowed = false;
  };

  $scope.updatePerson = function (person) {
    $scope.addOrEdit = "Edit person"
    $scope.newPerson = person;
  };
  $scope.destroyPerson = function (person) {
    person.$remove();
    index = $scope.people.indexOf(person);
    $scope.people.splice(index, 1);
  };

  $scope.deleteEmailAddress = function (email_address) {
    console.log(email_address);
    if (confirm("Are you sure?")) {
      email_address._destroy = 1;
    };
  };

  $scope.deletePhoneNumber = function (phone_number) {
    console.log(phone_number);
    if (confirm("Are you sure?")) {
      phone_number._destroy = 1;
    };
  };

  $scope.addFieldEmail = function () {
    $scope.newPerson.email_addresses_attributes.push({email: ""})
  };

  $scope.addFieldPhone = function () {
    $scope.newPerson.phone_numbers_attributes.push({phone_number: ""})
  };

  $scope.sort = 'first_name';
}]);
