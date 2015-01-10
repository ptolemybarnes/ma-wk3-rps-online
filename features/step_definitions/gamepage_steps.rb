require 'cucumber/rspec/doubles'

Given(/^I press "(.*?)" and the opponent chooses "(.*?)"$/) do |mychoice, compchoice|
  RockPaperScissorGame.should_receive(:random_choice).and_return(compchoice.to_sym)
  click_button(mychoice)
end