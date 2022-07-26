Feature: Testing API user not found

  Scenario: Testing API using get request method to verify the user not found
    Given url "https://reqres.in/api/users/23"
    When method get
    Then status 404
    And print response
