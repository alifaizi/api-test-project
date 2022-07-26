Feature: Get Request Demo

  Background: 
    * url "https://reqres.in/api"
    * header Accept = "application/json"

  # Simple get request
  Scenario: Testing get request 1
    Given url "https://reqres.in/api/users?page=2"
    When method get
    Then status 200
    And print response
    And print responseStatus
    And print responseTime
    And print responseHeaders
    And print responseCookies

  # Get request with Background
  Scenario: Testing get request method 2
    Given path "/users?page=2"
    When method get
    Then status 200
    And print response

  # Get with path and parameters
  Scenario: Testing get request method 3
    Given path "/users"
    And param page = 2
    When method get
    Then status 200
    And print response

  # Get with Assertions
  Scenario: Testing get request method 4
    Given path "/users"
    And param page = 2
    When method get
    Then status 200
    And print response
    And match response.data[0].first_name != null
    And assert response.data.length == 6
    And match response.data[3].id == 10
    # We can also use $ instead of response
    And match $.data[0].last_name == "Lawson"
