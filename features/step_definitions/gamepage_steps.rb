Given(/^I press "(.*?)" and the computer chooses "(.*?)"$/) do |mychoice, compchoice|
  click_button(mychoice)
end