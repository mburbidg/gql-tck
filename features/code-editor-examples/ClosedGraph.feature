#encoding: utf-8

Feature: Example with closed graph type

  Scenario: [1] Create graph
    Given any catalog
    When executing query:
      """
      CREATE GRAPH IF NOT EXISTS socialNetworkGraphType
         TYPED {
              /* Node types */
              (Person :Person { "lastname" STRING, "firstname" STRING, "joined" DATE}),
              (City :City { "name" STRING, "state" STRING, "country" STRING}),
              (Pet :Pet { "name" STRING, "type" STRING}),
              /* Edge types */
              (Person)-[:LIVES_IN { "since" DATE }]->(City),
              (Person)-[:KNOWS]->(Person)
         }
      """
    Then the result should be empty
    And the side effects should be:
      | +graphs | 1 |

  Scenario: [2] Create graph like
    Given any catalog
    When executing query:
      """
      CREATE GRAPH mySocialNetwork LIKE socialNetworkGraphType
      """
    Then the result should be empty
    And the side effects should be:
      | +graphs | 1 |


  Scenario: [3] Insert person
    Given any graph
    When executing query:
      """
      INSERT (:Person { "firstname":"Keith", "lastname":"Hare", "joined": DATE "2022-08-23" })
             -[:LIVES_IN { "since": DATE "1980-07-15" }]->
             (:City { "name": "Granville", "state": "OH", "country": "USA" })
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 1 |

  Scenario: [4] Insert pet
    Given any graph
    When executing query:
      """
      INSERT (:Pet { "name": "Winnifred", "type": "Dog" })
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 1 |

  Scenario: [5] Match/Insert typed graph
    Given any graph
    When executing query:
      """
      /*
         The following insert fails because graph type
         does not include a HasPet relationship
      */
      MATCH (a { "firstname": "Keith" }), (d { "name": "Winnifred" })
      INSERT (a)-[:HasPet]->(d)
      """
    Then the result should be empty
    And the side effects should be:
      | +nodes | 1 |
