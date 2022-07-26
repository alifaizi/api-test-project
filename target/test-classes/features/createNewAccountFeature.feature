Feature: Create account with data generator

  Background: generate  token for all Scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generateToken = response.token

  Scenario: Creat new account happy path
    * def generator = Java.type('tiger.api.test.data.DataGenerator')
    * def email = generator.getEmail()
    * def firstname = generator.getFirstName()
    * def lastname = generator.getLastName()
    * def dob = generator.getDOB()
    And print email
    And print firstname
    And print lastname
    And print dob
    Given path "/api/accounts/add-primary-account"
    And request  
      """
      {
      "email": "#(email)", 
      "title": "Mr.", 
      "firstName": "#(firstName)", 
      "lastName": "lastName", 
      "gender": "MALE", 
      "maritalStatus": "MARRIED", 
      "employmentStatus": "Employed", 
      "dateOfBirth": "2022-07-18T23:16:41.471Z", 
      "new": true
      }
      """
    And header Authorization = "Bearer " + generateToken
    When method post
    Then status 201
    * def generatedId = response.id
    And print generatedId
    And print response
    Then assert response.email == email
    And print response
    
    