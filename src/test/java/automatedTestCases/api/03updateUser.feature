Feature: Validate Update User

  Background:
    Given url 'https://gorest.co.in'
    And header Authorization = "Bearer " + "7078d0b3046e305516f84885cae16a9b57a5b1c3f87789dca92502175abf9173"
    And def fileData = karate.read('file:/Users/raramuri/IdeaProjects/rest_assured_assignment/target/responseData.json')


  Scenario: Updating gender of user with valid id.
    And path '/public/v1/users' , fileData.data.id
    And request
    """
    {
        "status" : "inactive"
    }
    """
    When method put
    Then status 200
    And match response.data.status == "inactive"

  Scenario: Updating name of user with valid id.
    Given path '/public/v1/users' , fileData.data.id
    And request
    """
    {
        "name" : "Smith John"
    }
    """
    When method put
    Then status 200
    And match response.data.name == "Smith John"

  Scenario: Updating status of user with invalid id.
    Given path '/public/v1/users' , 76234
    And request
    """
    {
        "status" : "sleeping"
    }
    """
    When method put
    Then status 404
    And match response.data.message == "Resource not found"
