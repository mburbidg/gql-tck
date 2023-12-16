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

  Scenario: [3] Insert pet
    Given any graph
    When executing query:
      """
      INSERT (:Pet { "name": "Winnifred", "type": "Dog" })
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 1 |

  Scenario: [4] Match/Insert untyped graph
    Given any graph
    When executing query:
      """
      /*
         The following INSERT succeeds because there are
         no restrictions on the contents of the graph.
      */
      MATCH (a { "firstname": "Keith" }), (d { "name": "Winnifred" })
      INSERT (a)-[:HasPet]->(d)
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 1 |
