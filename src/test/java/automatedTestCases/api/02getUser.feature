Feature: Validate Get User

  Background:
    Given url 'https://gorest.co.in'
    And header Authorization = "Bearer " + "7078d0b3046e305516f84885cae16a9b57a5b1c3f87789dca92502175abf9173"

  Scenario: Fetching user with valid id.
    Given def fileData = karate.read('file:/Users/raramuri/IdeaProjects/rest_assured_assignment/target/responseData.json')
    And path '/public/v1/users/' , fileData.data.id
    When method get
    Then status 200
    And match response.data.id == fileData.data.id
    And match response.data.name == fileData.data.name
    And match response.data.email == fileData.data.email
    And match response.data.gender == fileData.data.gender
    And match response.data.status == fileData.data.status

  Scenario: Fetching user with invalid id.
    Given path '/public/v1/users/' , 724653
    When method get
    Then status 404
    And match response.data.message == "Resource not found"
