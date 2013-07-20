Feature: Example demonstrating honeydew

  Scenario: Perform addition using calculator
    When I launch app Calculator
    Then I square root 625
    Then I should see 25 as the result