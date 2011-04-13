# encoding: UTF-8
require 'spec_helper'

describe "Javascript QUnit tests", :type => :request, :js => true do
  # iterate through the *_spec.js.erb files in the spec/javascript folder
  Dir.new(Rails.root.join('spec/javascript')).each do |d|
    match = /^(.+)_spec\.js\.erb$/.match(d)
    unless match.blank?
      file = match[1]
      it "should pass when executing test '#{file}'" do
        MAX_RUNNING_TIME_PER_SCRIPT = 60 # max time for each QUnit test

        delays = 0
        visit javascript_test_path(file)
        while delays < MAX_RUNNING_TIME_PER_SCRIPT
          doc = Nokogiri::HTML(page.body)
          if (doc.css('#qunit-testresult .passed').empty?)
            sleep 1
            delays = delays + 1
          else
            break
          end
        end
        if (doc.css('#qunit-testresult .passed').empty?)
          false.should eql(true), "The tests failed and did not complete within #{MAX_RUNNING_TIME_PER_SCRIPT}s"
        else
          doc.css('ol#qunit-tests>li').each do |test|
            test.css('.counts .failed').text.strip.should eql("0"), "QUnit test '#{test.css('span.test-name').text.strip}' failed"
          end
        end
      end
    end
  end
end