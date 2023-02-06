
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()


    Scenario: New user Sign Up

        Given path 'users'
        And request 
        """
            {
                "user": {
                        "email": #(randomEmail),
                        "password": "aoisdjioads",
                        "username": #(randomUsername)
                        }
            }
        """
        When method Post
        Then status 200
        And match response == 
        """
            {
                "user": {
                        "email": #(randomEmail),
                        "username": #(randomUsername),
                        "bio": "##string",
                        "image": "#string",
                        "token": "#string"
                            }
            }
        """

    Scenario Outline: Validate Sign Up error messages
            Given path 'users'
            And request 
            """
                {
                    "user": {
                            "email": "<email>",
                            "password": "<password>",
                            "username": "<username>"
                            }
                }
            """
            When method Post
            Then status 422
            And match response == <errorResponse>

            Examples:
                    | email               | password    | username            | errorResponse                                     |
                    | #(randomEmail)      | Pokemon1411 | Trabuch21           |{"errors":{"username":["has already been taken"]}} |
                    | trabuch21@gmail.com | Pokemon1411 | #(randomUsername)   |{"errors":{"email":["has already been taken"]}}    |
                    #| trabuch21           | Pokemon1411 | #(randomUsername)   |{"errors":{"email":["is invalid"]}}                |
                    |                     | Pokemon1411 | #(randomUsername)   |{"errors":{"email":["can't be blank"]}}            |
                    | #(randomEmail)      |             | #(randomUsername)   |{"errors":{"password":["can't be blank"]}}         |
