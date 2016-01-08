
var app = angular.module('AddressBook', ['ngResource'])

app.factory('Person', ['$resource', function($resource){
  return $resource('/people/:id', {id: '@id'}, {update: {method: 'PUT'}})
}]);

app.factory('EmailAddress', ['$resource', function($resource){
  return $resource('/email_addresses/:id', {id: '@id'}, {update: {method: 'PUT'}})
}])

app.factory('PhoneNumber', ['$resource', function($resource){
  return $resource('/phone_numbers/:id', {id: '@id'}, {update: {method: 'PUT'}})
}])

app.controller('PeopleCtrl', ['$scope', 'Person', 'EmailAddress', 'PhoneNumber', function($scope, Person, EmailAddress, PhoneNumber){
  $scope.people = Person.query();
  $scope.newPerson = {email_addresses_attributes: [{email: ""}], phone_numbers_attributes: [{phone_number: ""}]}
  $scope.newPerson = {email_addresses_attributes: [{email: ""}], phone_numbers_attributes: [{phone_number: ""}]}
  $scope.addPerson = function () {
    if ($scope.newPerson.id) {
      $scope.newPerson.$update()
      $scope.newPerson = {email_addresses_attributes: [{email: ""}], phone_numbers_attributes: [{phone_number: ""}]}
    }
    else {
      person = Person.save($scope.newPerson).$promise.then(function (responce) {
        console.log(responce)
        $scope.people.push(responce);
        $scope.newPerson = {email_addresses_attributes: [{email: ""}], phone_numbers_attributes: [{phone_number: ""}]}
      })
    }
  };
  $scope.personShowed = false
  $scope.showPerson = function(person) {
    $scope.personShowed = true
    $scope.firstName = person.first_name
    $scope.lastName = person.last_name
    $scope.emails = person.email_addresses_attributes
    $scope.phoneNumbers = person.phone_numbers_attributes

  };
  $scope.showPeople = function() {
    $scope.personShowed = false
  };

  $scope.updatePerson = function (person) {
    $scope.newPerson = person
  }
  $scope.destroyPerson = function (person) {
    person.$remove()
    index = $scope.people.indexOf(person)
    $scope.people.splice(index, 1)
  }

  $scope.deleteEmailAddress = function (email_address) {
    console.log(email_address)
    if (confirm("Are you sure?")) {
      EmailAddress.remove(email_address)
      index = $scope.newPerson.email_addresses_attributes.indexOf(email_address)
      $scope.newPerson.email_addresses_attributes.splice(index, 1)
    };
  }

  $scope.deletePhoneNumber = function (phone_number) {
    console.log(phone_number)
    if (confirm("Are you sure?")) {
      PhoneNumber.remove(phone_number)
      index = $scope.newPerson.phone_numbers_attributes.indexOf(phone_number)
      $scope.newPerson.phone_numbers_attributes.splice(index, 1)
    };
  }

  $scope.addFieldEmail = function () {
    $scope.newPerson.email_addresses_attributes.push({email: ""})
  }

  $scope.addFieldPhone = function () {
    $scope.newPerson.phone_numbers_attributes.push({phone_number: ""})
  }

  $scope.sort = 'first_name'
}])
