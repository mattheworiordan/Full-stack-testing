Then /^I should not be shown any calculator history$/ do
  page.has_css?('ul.history li').should == false
end