@honeydew
Feature: Example demonstrating honeydew
  Scenario: Perform addition using calculator
    When I launch app "Calculator"
    Then I long press the element with description "square root"
    Then I press the "6" button
    Then I press the "2" button
    Then I press the "5" button
    And I press the "=" button
    Then I wait up to 2 seconds for "25" to appear in edit text