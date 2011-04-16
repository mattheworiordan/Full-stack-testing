Given /^I expect to click "([^"]*)" on a confirmation box saying "([^"]*)"$/ do |option, message|
  retval = (option == "OK") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg, {path: '/'});
    return #{retval};
  }")

  @expected_message = message
end

Then /^the confirmation box should have been displayed$/ do
  page.evaluate_script("$.cookie('confirm_message')").should_not be_nil
  page.evaluate_script("$.cookie('confirm_message')").should eq(@expected_message)
  page.evaluate_script("$.cookie('confirm_message', null)")
end

Given /^I expect to click on an alert box saying "([^"]*)"$/ do |message|
  page.evaluate_script("window.alert = function (msg) {
    $.cookie('alert_message', msg, {path: '/'});
    return true;
  }")

  @expected_message = message
end

Then /^the alert box should have been displayed$/ do
  page.evaluate_script("$.cookie('alert_message')").should_not be_nil
  page.evaluate_script("$.cookie('alert_message')").should eq(@expected_message)
  page.evaluate_script("$.cookie('alert_message', null)")
end