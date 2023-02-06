Feature: Create Token

    Scenario: Create token
        Given url apiUrl
        Given path 'users/login'
        And request {"user": {"email":"#(userEmail)","password":"#(userPassword)"}}
        When method post
        Then status 200
        * def authToken = response.user.token