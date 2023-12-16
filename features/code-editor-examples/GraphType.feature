#encoding: utf-8

Feature: Example graph types

  Scenario: [1] Create graph type
    Given any catalog
    When executing query:
      """
      CREATE GRAPH TYPE IF NOT EXISTS socialNetworkGraphType
      AS {
          (Person :Person { "lastname" STRING, "firstname"  STRING, "joined" DATE }),
          (City :City { "name" STRING, "state" STRING, "country" STRING}),
          (Pet :Pet { "name" STRING, "type" STRING}),
          (Person)-[:LIVES_IN {"since" DATE}]->(City),
          (Person)-[:KNOWS]->(Person)
      }
      """
    Then the result should be empty
    And the side effects should be:
      | +graphTypes | 1 |
