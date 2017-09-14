Feature: Working with notes

  Background:
    Given a contact named "Jantje"
    And an note with id "2017-06"

  Scenario: Notes are immutable
    When we try to edit the note
    Then saving should not succeed

  Scenario: A note should generate a pdf file
    Then a pdf should have been generated alongside it

  Scenario: Creating an note
    Given the user is on the page to create a new note
    When the user fills in the note information
    And the user clicks on the submit button
    Then an note is created
    And the user should see the new note

  Scenario Outline: Incrementing note numbers
    Given the year is <year>
    When we create a new note
    Then the note id should be <id>

    Examples:
      | year | id |
      | 2017 | 2017-07 |
      | 2018 | 2018-01 |
