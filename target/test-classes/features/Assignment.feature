
Feature: Adding new details to an existing account
  # Token for all scenarios
  Background: Token for all scenarios
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
  # 2)Test API endpoint "/api/accounts/add-primary-account" to add new Account with Existing email address.
  # Then status code should be 400 – Bad Request ,  validate response
  Scenario: Adding new account with existing email email
    Given path "/api/accounts/add-primary-account"
    And request {"id": 50, "email": "ali.faizi@yahoo.com", "title": "Mr.", "firstName": "Ali","lastName": "Faizi", "gender": "MALE", "maritalStatus": "MARRIED", "employmentStatus": "Employed", "dateOfBirth": "2022-07-18T23:16:41.471Z", "new": true}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Account with Email ali.faizi@yahoo.com is exist"
  # 3)Test API endpoint "/api/accounts/add-account-car" to add car to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Adding car to an existing account
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = 53
    And request {"make": "Toyota", "model": "Camry", "year": "2018", "licensePlate": "abc123"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
  # 4)Test API endpoint "/api/accounts/add-account-phone" to add Phone number to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Adding phone number to an existing account
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = 53
    And request {"phoneNumber": "202-111-2222", "phoneExtension": "12", "phoneTime": "Any Time", "phoneType": "Mobile"}
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
  # 5)Test API endpoint "/api/accounts/add-account-address" to add address to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Adding address to an existing account
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = 53
    And request {"addressType": "Home", "addressLine1": "5050 Seminary Road, Apt 12345", "city": "Alexandria", "state": "Virginia", "postalCode": "22311", "countryCode": "+1", "current": true}
    And header Authorization = "Bearer " + generatedToken
    When method post
    And status 201
    And print response
