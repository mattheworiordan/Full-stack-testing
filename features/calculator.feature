Feature: Calculator
  In order to calculate an operation
  As a visitor
  I want to be told the result of a maths operation

  Scenario: Access the calculator
    Given I am on the home page
    When I follow "Use the calculator"
    Then I should see /Integer Calculator/ within "h1"
      And I should see "0" within ".value"
      And the "Modify value" field should contain "0"

  Scenario: Use the calculator for simple calculations
    Given I am on the calculator page
    When I fill in "Modify value" with "10"
      And I press "+"
    Then I should see "10" within ".value"
      And I should see "0 + 10" within ".history"
      And the "Modify value" field should contain "0"

    When I fill in "Modify value" with "5"
      And I press "*"
    Then I should see "50" within ".value"
      And I should see "* 5" within ".history"

    When I fill in "Modify value" with "0"
      And I press "/"
    Then I should see /You cannot divide by zero/ within ".flash-error"
      And I should see "50" within ".value"
      And I should not see "/ 0" within ".history"

    # by pressing = nothing should happen to the value, = just returns current calc value
    When I fill in "Modify value" with "5"
      And I press "="
    Then I should see "50" within ".value"

    When I fill in "Modify value" with "alphabetical characters"
      And I press "+"
    Then I should see "This calculator only supports numerical characters" within ".flash-error"

    When I fill in "Modify value" with "-5"
      And I press "/"
    Then I should see "-10" within ".value"
      And I should not see "/ -10" within ".history"

    When I press "C"
    Then I should see "0" within ".value"
      And I should not be shown any calculator history

  @javascript
  Scenario: Use the Javascript based functions
    Given I am on the calculator page
    When I press "2"
      And I press "5"
      And I press "+"
    Then I should see "25" within ".value"
    When I press "√"
      Then I should see "5" within ".value"

  @selenium
  Scenario: Test a JQuery UI dialog
    Given I am on the calculator page
    When I press "2"
      And I press "+"
    Then I should see "2" within ".value"
    When I press "C"
    Then I should see "Are you sure you want to clear the calculator and history?" within "#dialog-confirm"
    When I press "Yes"
    Then I should see "0" within ".value"
      And I should not see "2" within ".history"