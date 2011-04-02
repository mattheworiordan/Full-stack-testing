Then /^I should not be shown any calculator history$/ do
  page.has_css?('.history').should == false
end