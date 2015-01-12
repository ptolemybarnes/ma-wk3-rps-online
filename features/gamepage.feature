Feature: Playing rock, paper, scissor
  In order to play rock, paper, scissor
  As a player who wants to resolve an argument
  I want to choose rock, paper, or scissor.

# Single player versus human opponent

# Adding a human opponent.
    Scenario: I am on the newgame page and want to add a human opponent.
      Given I am on the newgame page
      # Then I should see "How many human opponents?"
      And I fill in "human_player_count" with "2"
      And I press "submit"
      Then I should see "Waiting for human opponent to join..."


    





