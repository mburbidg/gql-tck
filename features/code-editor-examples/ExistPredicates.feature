#encoding: utf-8

Feature: Example with exists predicates

  Scenario: [1] Match with exists predicate (match block statement in parentheses)
    Given any graph
    When executing query:
      """
      MATCH (p:Person)-[r:IS_FRIENDS_WITH]->(friend:Person)
      WHERE EXISTS (MATCH (p)-[:WORKS_FOR]->(:Company { name: "GQL, Inc."}))
      RETURN p, r, friend
      """
    Then the result should be empty
    And no side effects

  Scenario: [2] Match with exists predicate (match block statement in braces)
    Given any graph
    When executing query:
      """
      MATCH (p:Person)-[r:IS_FRIENDS_WITH]->(friend:Person)
      WHERE EXISTS {MATCH (p)-[:WORKS_FOR]->(:Company {name: "GQL, Inc."})}
      RETURN p, r, friend
      """
    Then the result should be empty
    And no side effects

  Scenario: [3] Match with exists predicate (nested match statement)
    Given any graph
    When executing query:
      """
      MATCH (p:Person)-[r:IS_FRIENDS_WITH]->(friend:Person)
      WHERE EXISTS { MATCH (p)-[:WORKS_FOR]->(:Company { name: "GQL, Inc." }) RETURN p }
      RETURN p, r, friend
      """
    Then the result should be empty
    And no side effects