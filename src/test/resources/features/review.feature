@EndToEndTest
Feature: Creating new account and adding address and phone and car in the new account

  Scenario: Creating new account and adding address, phone number, and car
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generateToken = response.token
    And print generateToken
    * def generator = Java.type('api.test.data.DataGeneratorForApiTest')
    * def email = generator.getEmail()
    * def phone = generator.getPhoneNumber()
    * def firstname = generator.getFirstName()
    * def lastname = generator.getLastName()
    * def dob = generator.getDateOfBirth()
    And print email
    And print phone
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
    And print response
    Then assert response.email == email
    And print response
    * def generator = Java.type('api.test.data.DataGeneratorForApiTest')
    * def street = generator.getStreet()
    * def city = generator.getCity()
    * def state = generator.getState()
    * def country = generator.getCountry()
    * def zipCode = generator.getZipCode()
    * def countryCode = generator.getCountryCode()
    And print street
    And print city
    And print state
    And print country
    And print zipCode
    And print countryCode
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + generateToken
    And param primaryPersonId = generatedId
    And request
      """
      {
      "addressType": "Apartment",
      "addressLine1": "5050 Somewhere Drive, Apt 222",
      "city": "Richmond",
      "state": "Virginia",
      "postalCode": "22033",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    * def generator = Java.type('api.test.data.DataGeneratorForApiTest')
    * def phone = generator.getPhoneNumber()
    * def extension = generator.getExtension()
    And print phone
    And print extension
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + generateToken
    And param primaryPersonId = generatedId
    And request
      """
      {
      "phoneNumber": "202-222-7777",
      "phoneExtension": "2277",
      "phoneTime": "Day",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + generateToken
    And param primaryPersonId = generatedId
    And request
      """
      {
      "make": "Totyota",
      "model": "Corolla",
      "year": "2022",
      "licensePlate": "ABC222"
      }
      """
    When method post
    Then status 201
    And print response
