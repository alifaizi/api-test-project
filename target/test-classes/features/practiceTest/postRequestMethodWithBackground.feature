Feature: Creating new record using post method

  Background: 
    * url "https://reqres.in/api"
    * header Accept = "application/json"

  #Simple post request
  Scenario: Adding a new record in the database using post request method
    Given url "https://reqres.in/api/users"
    And request {"name": "Ali", "job": "Student"}
    When method POST
    Then status 201
    And print response

  #Post request with background
  Scenario: Post demo with Background
    Given path "/users"
    And request {"name": "Ali", "job": "Student"}
    When method POST
    Then status 201
    And print response
