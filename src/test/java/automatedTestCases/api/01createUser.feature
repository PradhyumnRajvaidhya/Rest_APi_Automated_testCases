Feature: Validate Create User

  Background:
    Given url 'https://gorest.co.in'
    And header Authorization = "Bearer " + "7078d0b3046e305516f84885cae16a9b57a5b1c3f87789dca92502175abf9173"

  Scenario: Creating user with all necessary fields.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Pradhyumn Rajvaidhya",
        "email" : "pradyumnrajvaidya04@gmail.com",
        "gender" : "male",
        "status" : "active"
    }
    """
    When method post
    Then status 201
    And match response.data.name == "Pradhyumn Rajvaidhya"
    And match response.data.email == "pradyumnrajvaidya04@gmail.com"
    And match response.data.gender == "male"
    And match response.data.status == "active"
    And karate.write(response,"responseData.json")

  Scenario: Creating user with one missing fields in necessary fields.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Pradhyumn Rajvaidhya",
        "gender" : "male",
        "status" : "active"
    }
    """
    When method post
    Then status 422
    And match response.data[0].field == "email"
    And match response.data[0].message == "can't be blank"

  Scenario: Creating user with two missing fields in necessary fields.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Pradhyumn Rajvaidhya",
        "status" : "active"
    }
    """
    When method post
    And status 422
    And match response.data[0].field == "email"
    And match response.data[0].message == "can't be blank"
    And match response.data[1].field == "gender"
    And match response.data[1].message == "can't be blank, can be male of female"

  Scenario: Creating user with three missing fields in necessary fields.
    Given path '/public/v1/users'
    And request
    """
    {
       "name" : "Pradhyumn Rajvaidhya"
    }
    """
    When method POST
    And status 422
    And match response.data[0].field == "email"
    And match response.data[0].message == "can't be blank"
    And match response.data[1].field == "gender"
    And match response.data[1].message == "can't be blank, can be male of female"
    And match response.data[2].field == "status"
    And match response.data[2].message == "can't be blank"

  Scenario: Creating user without providing any fields.
    Given path '/public/v1/users'
    And request
    """
    {
    }
    """
    When method POST
    And status 422
    And match response.data[0].field == "email"
    And match response.data[0].message == "can't be blank"
    And match response.data[1].field == "name"
    And match response.data[1].message == "can't be blank"
    And match response.data[2].field == "gender"
    And match response.data[2].message == "can't be blank, can be male of female"
    And match response.data[3].field == "status"
    And match response.data[3].message == "can't be blank"

  Scenario: Creating user with existing email.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Pradhyumn Rajvaidhya",
        "email" : "pradyumnrajvaidya04@gmail.com",
        "gender" : "male",
        "status" : "active"
    }
    """
    When method post
    Then status 422
    And match response.data[0].field == "email"
    And match response.data[0].message == "has already been taken"

  Scenario: Creating user with all necessary fields and some extra fields.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Pradhyumn Rajvaidhya",
        "email" : "ajfbvhh9961111111@gmail.com",
        "gender" : "male",
        "status" : "active",
        "city" : "Bengaluru",
        "Company" : "ZopSmart"
    }
    """
    When method post
    Then status 422

  Scenario: Creating user with invalid email.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Pradhyumn Rajvaidhya",
        "email" : "sit120043h827jo@ma",
        "gender" : "male",
        "status" : "active"
    }
    """
    When method post
    Then status 422
    And match response.data[0].field == "email"
    And match response.data[0].message == "is invalid"


  Scenario: Creating user with invalid name.
    Given path '/public/v1/users'
    And request
    """
    {
       "name" : "878375&^@T&^jjd",
       "email" : "s022348mi@mail.com",
       "gender" : "male",
       "status" : "active"
    }
    """
    When method post
    Then status 422
    And match response.data[0].field == "name"
    And match response.data[0].message == "is invalid"

  Scenario: Creating user with more than 200 characters long email address.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Pradhyumn Rajvaidhya",
        "email" : "smithjbvekufhbhcnerbcnixmiwuyfbybaqzwdfvegmecmbefvubwejvbewkuvbwkvwkvbwvbwiufvbuwfvbwufvbwufvmbwiwbwiopwmpwiuyugrtttbcniuywbwunyvbyncbmweufgmnuwebguwebguegbcuegbuefgbcnuefgbchrgbjergbhjvnenhvoess@gmail.com",
        "gender" : "male",
        "status" : "active"
    }
    """
    When method post
    Then status 422
    And match response.data[0].field == "email"
    And match response.data[0].message == "is too long (maximum is 200 characters)"

  Scenario: Creating user with more than 200 characters long name.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "smithjbvekufhbhcnerbcnixmiwuyfbybaqzwdfvegmecmbefvubwejvbewkuvbwkvwkvbwvbwiufvbuwfvbwufvbwuifvmbwiwbwiopwmpwiuyugrtttbcniuywbwunyvbyncbmweufgmnuwebguwebguegbcuegbuefgjjefvjejnvjjkefvbcnuefgbjrjchrgbjergbhjvnenhvoess",
        "email" : "smithjbgbh2345678765476545offess@gmail.com",
        "gender" : "male",
        "status" : "active"
    }
    """
    When method post
    Then status 422
    And match response.data[0].field == "name"
    And match response.data[0].message == "is too long (maximum is 200 characters)"

  Scenario: Creating user with invalid gender.
    Given path '/public/v1/users'
    And request
    """
    {
       "name" : "Pradhyumn Rajvaidhya",
       "email" : "pradyumnrajvaidya04@gmail.com",
       "gender" : "boy",
       "status" : "active"
    }
    """
    When method post
    Then status 422
    Then match response.data[0].field == "gender"
    Then match response.data[0].message == "can't be blank, can be male of female"

  Scenario: Creating user with invalid status.
    Given path '/public/v1/users'
    And request
    """
    {
        "name" : "Smith Jones",
        "email" : "pradyumnrajvaidya04@gmail.com",
        "gender" : "male",
        "status" : "sleeping"
    }
    """
    When method post
    Then status 422
    Then match response.data[0].field == "status"
    Then match response.data[0].message == "can't be blank"

