Feature: Add likes

    Background: 
        * url apiUrl

    Scenario: add likes
    #in this case slug is one property that exists in the object that we are sending in other file
        Given path '/articles',slug,'favorite'
        And request {}
        When method Post
        Then status 200
    * def likesCount = response.article.favoritesCount