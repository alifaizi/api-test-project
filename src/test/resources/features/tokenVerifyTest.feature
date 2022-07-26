Feature: Security test. Verify Token Test

  Scenario: Verify valid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = generatedToken
    When method get
    Then status 200
    And print response

  # Scenario 2
  Scenario: Verify invalid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = "abc-xyz"
    When method get
    Then status 400
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Token Expired or Invalid Token"

  #Scenario 3
  Scenario: Test token verify with valid token and invalid username
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generateToken = response.token
    Given path "api/token/verify"
    And param username = "invalid-username"
    And param token = generateToken
    When method get
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Wrong Username send along with Token"
