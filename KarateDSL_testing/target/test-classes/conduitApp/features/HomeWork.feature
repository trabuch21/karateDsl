
Feature: Home Work

Background: Preconditions
    * url apiUrl 
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def articleSchemaValidator = read('classpath:conduitApp/json/articleResponse_schemaValidator.json')
    * def articlePathResponseSchemaValidator = read ('classpath:conduitApp/json/pathArticleReponse_schema.json')


@test
Scenario: Favorite articles
    Given path 'articles'
    # Step 1: Get atricles of the global feed
    When method get
    Then status 200
    # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
    * def initialCount = response.articles[0].favoritesCount
    * def slugID = response.articles[0].slug
    Then status 200

    
    # Step 3: Make POST request to increse favorites count for the first article
    Given path 'articles/'+slugID+'/favorite'
    And request {}
    When method Post
    Then status 200
    # Step 4: Verify response schema
    And match response.article == articlePathResponseSchemaValidator
    
    # Step 5: Verify that favorites article incremented by 1
        * match response.article.favoritesCount == initialCount + 1

    # Step 6: Get all favorite articles
    Given params {favorited:"trabuch21", limit: 10, offset: 0}
    Given path 'articles'
    When method get
    # Step 7: Verify response schema
    And match each response.articles == articleSchemaValidator
    
    # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
    And match response.articles[*].slug contains slugID
Scenario: Comment articles
    # Step 1: Get atricles of the global feed
    # Step 2: Get the slug ID for the first arice, save it to variable
    # Step 3: Make a GET call to 'comments' end-point to get all comments
    # Step 4: Verify response schema
    # Step 5: Get the count of the comments array lentgh and save to variable
        #Example
        #* def responseWithComments = [{"article": "first"}, {article: "second"}]
        #* def articlesCount = responseWithComments.length
    # Step 6: Make a POST request to publish a new comment
    # Step 7: Verify response schema that should contain posted comment text
    # Step 8: Get the list of all comments for this article one more time
    # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
    # Step 10: Make a DELETE request to delete comment
    # Step 11: Get all comments again and verify number of comments decreased by 1