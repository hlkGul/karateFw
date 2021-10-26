Feature: Education

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: get request
    And path '/store/inventory'
    When method GET

  Scenario: add query param
    And path '/pet/findByStatus'
    And param status = 'available'
    When method GET

  Scenario: def operation
    * def requestBody =
        """
        {
  "id": 0,
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
        """
    And path '/pet'
    And request requestBody
    When  method POST

  Scenario: add header and status check
    * def requestBody =
        """
        {
  "id": 0,
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
        """
    And path '/pet'
    And request requestBody
    And header user-agent = 'halukGul'
    When method POST
    Then status 200


  Scenario: response match and response time
    And path '/store/inventory'
    When method GET
    Then status 200
    Then match $.alive == 1
    Then assert responseTime < 2000


  Scenario: Read file
    * def requestBody = read('classpath:example.json')
    * requestBody.category.id = 03
    * requestBody.category.name = 'testinium'
    * print requestBody
    And path '/pet'
    And request requestBody
    When method POST
    Then status 200

  Scenario: use java function
    * def requestBody = read('classpath:example.json')

    * requestBody.name = 'testinium'
    * def myJsFun =
    """
    function(arg){
      return arg.length
    }
    """
    * def postedLength =  call myJsFun requestBody.name
    And path '/pet'
    And request requestBody
    When method POST
    * def responseLength = call myJsFun $.name
    * print postedLength
    * print responseLength
    Then match postedLength == responseLength

    @Feature
    Scenario: Feature
      * def requestBody = read('classpath:example.json')
      * requestBody.category.id = 26
      * requestBody.category.name = 'dog'
      * requestBody.name = 'duman'
      * requestBody.status = 'status'
      And path '/pet'
      And request requestBody
      When method POST

    Scenario: Feature in Feature
      * def petPostScenario = read('education.feature@Feature')
      * def result = call petPostScenario
      * print result
      * def petId = result.response.id
      * print petId
      * def petName = result.requestBody.name
      Given path '/v2/pet' .petId
      When method GET
      
