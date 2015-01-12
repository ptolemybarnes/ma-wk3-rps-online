Feature: Playing rock, paper, scissor
  In order to play rock, paper, scissor
  As a player who wants to resolve an argument
  I want to choose rock, paper, or scissor.

# Single player versus human opponent

# Adding a human opponent.

  Background: There are no games running
    Given I am on the clearallgames page
  
    Scenario: I am on the newgame page and want to add a human opponent.
      Given I am on the newgame page
      And I fill in "human_player_count" with "2"
      And I press "submit"
      Then I should see "Waiting for human opponent to join..."

    Scenario: I dont add a human opponent
      Given I am on the newgame page
      And I press "submit"
      Then I should not see "Waiting for human opponent to join..."

    Scenario: I go on the website when there is a game that can be joined
      Given I am on the newgame page
      And I fill in "human_player_count" with "2"
      And I fill in "name" with "Ptolemy"
      And I press "submit"
      Given I am on the newgame page
      Then I should see "Join game!"

    Scenario: I go on the website when there is a game but it is in progress
      Given I am on the newgame page
      And I press "submit"
      Given I am on the newgame page
      Then I should not see "Join game!"

    Scenario: I can join a game in progress.
      Given I am on the newgame page
      And I fill in "human_player_count" with "2"
      And I fill in "name" with "Ptolemy"
      And I press "submit"
      Given I am on the newgame page
      Then I should see "Game 1"
      And I press "joingame"
      Then I should see "Choose!"







    





