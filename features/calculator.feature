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

  @javascript
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

  @selenium
  Scenario: Test drag and drop functionality
    Given I am on the calculator page
    When I press "3"
      And I press "+"
      And I press "3"
      And I press "*"
    Then I should see "9"
    When I drag the value to the memory bank
    Then the memory bank should contain "9"

  @javascript
  Scenario: Ensure that user is asked to continue when performing an operation on a zero value
    Given I am on the calculator page
      And I expect to click "Cancel" on a confirmation box saying "Are you sure you want to perform this operation on a zero value.  If not, press cancel and enter a value before performing an operation."
    When I press "+"
    Then the confirmation box should have been displayed
      And I should not see "0" within ".history"

  @javascript
  Scenario: Ensure the user is prevented from dividing by zero once Javascript is enabled
    Given I am on the calculator page
      And I expect to click on an alert box saying "You cannot divide by zero"
    When I press "/"
    Then the alert box should have been displayed
      And I should not see "0" within ".history"

  @selenium
  Scenario: Ensure history is retained in cookies
    Given I am on the calculator page
      And the memory bank is cleared
    When I press "3"
      And I press "+"
      And I press "3"
      And I press "*"
    Then I should see "9"
    When I drag the value to the memory bank
    Then the memory bank should contain "9"
    When I follow "Home"
      And I follow "Use the calculator"
    Then the memory bank should contain "9"
