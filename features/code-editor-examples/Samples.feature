
#encoding: utf-8

Feature: Example with any graph type

  Scenario: [1] Create graph
    Given any catalog
    When executing query:
      """
      CREATE GRAPH mySocialNetwork :: ANY
      """
    Then the result should be empty
    And the side effects should be:
      | +graphs | 1 |

  Scenario: [2] Insert person
    Given any graph
    When executing query:
      """
      INSERT (:Person { "firstname": "Keith", "lastname": "Hare",
         "joined": DATE "2022-08-23" })
       -[:LIVES_IN { "since": DATE "1980-07-15" }]->
       (:City { "name":"Granville", "state":"OH",
         "country": "USA" })
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 1 |
