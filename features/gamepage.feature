Feature: Playing rock, paper, scissor
  In order to play rock, paper, scissor
  As a player who wants to resolve an argument
  I want to choose rock, paper, or scissor.

  # Single round

    Scenario: Rock versus paper
      Given I am on the homepage
      And I press "rock" and the computer chooses "paper"
      Then I should see "The computer chose paper. Paper wins!"

    Scenario: Paper versus rock
      Given I am on the homepage
      And I press "paper" and the computer chooses "rock"
      Then I should see "The computer chose rock. Paper wins!"

    Scenario: Scissors versus rock
      Given I am on the homepage
      And I press "scissor" and the computer chooses "rock"
      Then I should see "The computer chose rock. Rock wins!"

    Scenario: Tie
      Given I am on the homepage
      And I press "rock" and the computer chooses "rock"
      Then I should see "The computer chose rock. Game was a tie."

# Three rounds

    Scenario: Player wins in three rounds
      Given I am on the homepage to play "3" rounds
      Then I should see "Round 3: Choose!"
      And I press "rock" and the computer chooses "scissor"
      Then I should see "Round 2: Choose!"

    Scenario: Player wins in one round
      Given I am on the homepage to play "1" rounds
      And I press "rock" and the computer chooses "scissor"
      Then I should not see "Round 0: Choose!"



