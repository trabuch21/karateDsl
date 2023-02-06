#include classpath:helpers/test.js
@debug
Feature: Hooks

    Background: hooks
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def result = callonce read('classpath:helpers/Dummy.feature')
        * def username = result.username

        #after hook / also afterScenario
        * configure afterScenario = function(){karate.call('classpath:helpers/Dummy.feature')}
        * configure afterFeature = dataGenerator.loginFn()
    
    Scenario: First Scenario
        * print username
        * print 'This is first scenario'

    Scenario: Second Scenario
        * print username
        * print 'This is second scenario'