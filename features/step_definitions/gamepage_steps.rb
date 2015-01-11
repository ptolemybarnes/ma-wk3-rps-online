require 'cucumber/rspec/doubles'

Given(/^I press "(.*?)" and the opponent chooses "(.*?)"$/) do |mychoice, compchoice|
  RockPaperScissorGame.should_receive(:random_choice).and_return(compchoice.to_sym)
  click_button(mychoice)
end

Then(/^I press "(.*?)" and the opponents choose "(.*?)" and "(.*?)"$/) do |mychoice, opp1choice, opp2choice|
  RockPaperScissorGame.should_receive(:random_choice).and_return(opp1choice.to_sym, opp2choice.to_sym)
  click_button(mychoice)
end
