Feature: Validate Delete User

  Background:
    Given url "https://gorest.co.in"
    And header Authorization = "Bearer " + "7078d0b3046e305516f84885cae16a9b57a5b1c3f87789dca92502175abf9173"
    And def fileData = karate.read('file:/Users/raramuri/IdeaProjects/rest_assured_assignment/target/responseData.json')

  Scenario: Deleting user with valid id.
    Given path '/public/v1/users/' , fileData.data.id
    When method delete
    Then status 204

  Scenario: Deleting user with invalid id.
    Given path '/public/v1/users/' , 8273
    When method delete
    Then status 404