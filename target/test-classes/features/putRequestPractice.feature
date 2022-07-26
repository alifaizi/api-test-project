Feature: Updating an existing account with Put Request Method

Background: generate new token
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"
And request {"username": "supervisor", "password": "tek_supervisor"}
When method post
Then status 200
And print response
* def newToken = response.token

Scenario: Update phone number of an specific account using put request
Given path "/api/accounts/update-account-phone"
And param primaryPersonId = 777
And request {"id": 777, "phoneNumber": "202-222-2222", "phoneExtension": "222", "phoneTime": "Any Time", "phoneType": "Mobile"}
And header Authorization = "Bearer " + newToken
When method put 
Then status 200
And print response
