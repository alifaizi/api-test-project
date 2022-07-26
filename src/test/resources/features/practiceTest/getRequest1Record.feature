Feature: Testing API with get request for only 1 record

  Scenario: Testing API using get request method for one record
    Given url "https://reqres.in/api/users/2"
    When method get
    Then status 200
    And print response
