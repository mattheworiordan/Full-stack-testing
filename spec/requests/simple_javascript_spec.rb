# encoding: UTF-8
require 'spec_helper'

describe "the calculator", :type => :request do
  it "has buttons added by Javascript", :js => true do
    visit calculator_path
    within("#calculator") do
      click_button '1'
    end
  end

  it "has a calculator object in the global space", :js => :selenium do
    visit calculator_path
    within("#calculator") do
      click_button '1'
    end
    page.evaluate_script('$("#calculator").data("engine").sum(1,2)').should eql(3)
  end
end