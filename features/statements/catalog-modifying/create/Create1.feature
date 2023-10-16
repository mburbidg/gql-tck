
#encoding: utf-8

Feature: Create1 - Creating schemas

  Scenario: [1] Create a schema at the root
    Given any catalog
    When executing query:
      """
      CREATE SCHEMA IF NOT EXISTS /movies
      """
    Then the result should be empty
    And the side effects should be:
      | +schemas | 1 |
