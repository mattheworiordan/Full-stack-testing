Then /^I should not be shown any calculator history$/ do
  page.has_css?('ul.history li').should == false
end

When /^I drag the value to the memory bank$/ do
  value = page.find('#calculator .value')
  memory_bank = page.find('#memory-bank')
  value.drag_to memory_bank
end

Then /^the memory bank should contain "([^"]+)"$/ do |content|
  match =  false
  within('#memory-bank') do
    all('li').each do |memory|
      match = true if memory.has_content?(content)
    end
  end
  match.should eql(true)
end

Given /^the memory bank is cleared$/ do
  page.execute_script("$('#calculator').data('storage').clearMemoryBank({ preventDefault: function() { } });")
  within('#memory-bank') do
    all('li').should be_empty
  end
end