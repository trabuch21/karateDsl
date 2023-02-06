
Feature: Tests for the home page

Background: Define URL
    * url apiUrl
    * def articleSchemaValidator = read('classpath:conduitApp/json/articleResponse_schemaValidator.json')
    * def timeValidator = read('classpath:helpers/timeValidator.js')

Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['welcome', 'ipsum']
    And match response.tags !contains 'truck'
    And match response.tags == "#array"
    And match each response.tags == "#string"


@testing2
Scenario: Get 10 articles from the page
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response == {"articles":"#[10]", "articlesCount":220}
    And match each response.articles == articleSchemaValidator

@testing
    Scenario: Conditional Logic
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

       # * if (favoritesCount == 0 ) karate.call('classpath:helpers/AddLikes.feature', article)
       * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].favoritesCount == result

@retry
Scenario: Retry call
    * configure retry = {count: 10, interval: 5000}
    Given params {limit: 10, offset: 0}
    Given path 'articles'
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200

@sleep
Scenario: Retry call
    * def sleep = function(pause){ java.lang.Thread.sleep(pause)}

    Given params {limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    * eval sleep(5000)
    Then status 200

