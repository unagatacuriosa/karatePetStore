Feature: pet store karate

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: Create a new pet
    Given path '/pet'
    And request { "id": 0, "name": "doggie", "status": "available" }
    When method post
    Then status 200
    And match response.status == 'available'

  Scenario: Update a pet
    Given path '/pet'
    And request { "id": 0, "name": "doggie", "status": "no available" }
    When method put
    Then status 200
    And match response.status == 'no available'

  Scenario: Find a pet
    Given path '/pet/findByStatus'
    And param status = 'available'
    When method get
    When status 200
    * def responseList = response
    * def firstPetId = responseList[0].id
    * karate.set('firstPetId', firstPetId)

    Given path '/pet',firstPetId
    When method get
    Then status 200
    And match response.status == 'available'

  Scenario: Delete a pet
    Given path '/pet/findByStatus'
    And param status = 'available'
    When method get
    When status 200
    * def responseList = response
    * def firstPetId = responseList[0].id
    * karate.set('firstPetId', firstPetId)

    Given path '/pet',firstPetId
    When method delete
    Then status 200

    Given path '/pet',firstPetId
    When method get
    Then status 404