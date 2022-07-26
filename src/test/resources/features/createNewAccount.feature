Feature: Create Account

  # 1) Test API endpoint "/api/accounts/add-primary-account" to 
  #add new Account. Then status code should be 201 - CREATED, 
  #with response generate account with Email address
  
  Background: generate  token for all Scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generateToken = response.token

  Scenario: Creat new account happy path
    Given path "/api/accounts/add-primary-account"
    And request {"id": 10000, "email": "ali.faizi@yahoo.com", "title": "Mr.", "firstName": "Ali","lastName": "Faizi", "gender": "MALE", "maritalStatus": "MARRIED", "employmentStatus": "Employed", "dateOfBirth": "2022-07-18T23:16:41.471Z", "new": true}
    And header Authorization = "Bearer " + generateToken
    When method post
    Then status 201
    And print response
