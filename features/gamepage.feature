Feature: Playing rock, paper, scissor
  In order to play rock, paper, scissor
  As a player who wants to resolve an argument
  I want to choose rock, paper, or scissor.

    # Scenario: I enter my name
    #   Given I am on the homepage
    #   Then I should see "What's your name?"

  # Single round, versus Computer

    Scenario: Rock versus paper
      Given I am on the homepage
      And I press "rock" and the opponent chooses "paper"
      Then I should see "The opponent chose paper. Paper wins!"

    Scenario: Paper versus rock
      Given I am on the homepage
      And I press "paper" and the opponent chooses "rock"
      Then I should see "The opponent chose rock. Paper wins!"

    Scenario: Scissors versus rock
      Given I am on the homepage
      And I press "scissor" and the opponent chooses "rock"
      Then I should see "The opponent chose rock. Rock wins!"

    Scenario: Tie
      Given I am on the homepage
      And I press "rock" and the opponent chooses "rock"
      Then I should see "The opponent chose rock. Game was a tie."

# Multiple rounds, versus Computer

    Scenario: Player wins in three rounds
      Given I am on the homepage to play "3" rounds
      Then I should see "Round 3: Choose!"
      And I press "rock" and the opponent chooses "scissors"
      Then I should see "Score: You, 1. Opponent, 0"
      And I press "rock" and the opponent chooses "scissors"
      Then I should not see "You are the winner!"
      And I press "scissors" and the opponent chooses "paper"
      Then I should see "You won the game!"

    Scenario: Opponent wins in 1 round
      Given I am on the homepage to play "1" rounds
      And I press "paper" and the opponent chooses "scissors"
      Then I should see "Score: You, 0. Opponent, 1"
      And I should see "The opponent won the game!"

    Scenario: Player wins in one round
      Given I am on the homepage to play "1" rounds
      And I press "rock" and the opponent chooses "scissors"
      Then I should not see "Round 0: Choose!"

# Multiple players.



