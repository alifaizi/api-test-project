
Feature: Create an account and add address to the account

   #Step 1) Get a token
   #Step 2) Generate and account
   #Step 3) Add address to generated account
  
  Background: Create new account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def newAccountResult = callonce read("createNewAccountWithGenerateToken.feature")
    And print newAccountResult
    * def primaryPersonId = newAccountResult.response.id
    * def token = newAccountResult.result.response.token

  Scenario: Add address to an account
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = primaryPersonId
    And header Authorization = "Bearer " + token
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "5021 Alexandria Drive",
      "city": "Alexandria",
      "state": "Virginia",
      "postalCode": "22033",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response