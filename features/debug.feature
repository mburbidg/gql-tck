#encoding: utf-8

Feature: Debug - Creating schemas

  Scenario: [5] Fail when creating a schema with the same path as an existing directory
    Given any catalog
    When executing query:
      """
      CREATE SCHEMA /my_schemas
      """
    Then an exception condition should be raised: 42000
