Feature: PUT API Request

  Background: generate  token for all Scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token

  Scenario: Creat new account happy path
    Given path "/api/accounts/add-primary-account"
    And request {"id": 0, "email": "donaldtrump007@tekschool.com", "title": "Mr.", "firstName": "Donald","lastName": "Trump", "gender": "MALE", "maritalStatus": "MARRIED", "employmentStatus": "Unemployed", "dateOfBirth": "04/01/1950"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Account with Email donaldtrump007@tekschool.com is exist"

  #Scenario: Adding phone number to an existing account
  #Given path "/api/accounts/add-account-phone"
  #And param primaryPersonId = 8267
  #And request {"phoneNumber": "202-222-4444", "phoneExtension": "222", "phoneTime": "Any Time", "phoneType": "Mobile"}
  #And header Authorization = "Bearer " + generatedToken
  #When method post
  #Then status 201
  #And print response
  
  Scenario: Updating phone number in an existing account
    Given path "/api/accounts/update-account-phone"
    And param primaryPersonId = 8267
    And request {"phoneNumber": "202-111-1111", "phoneExtension": "111", "phoneTime": "Day", "phoneType": "Mobile"}
    And header Authorization = "Bearer " + generatedToken
    When method put
    Then status 200
    And print response
