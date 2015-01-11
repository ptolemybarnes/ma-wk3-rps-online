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
      Then I should see "Paper wins!"

    Scenario: Paper versus rock
      Given I am on the homepage
      And I press "paper" and the opponent chooses "rock"
      Then I should see "Paper wins!"

    Scenario: Scissors versus rock
      Given I am on the homepage
      And I press "scissor" and the opponent chooses "rock"
      Then I should see "Rock wins!"

    Scenario: Tie
      Given I am on the homepage
      And I press "rock" and the opponent chooses "rock"
      Then I should see "Game was a tie."

# Multiple rounds, versus Computer

    Scenario: Player wins in three rounds
      Given I am on the homepage to play "3" rounds
      Then I should see "Round 3: Choose!"
      And I press "rock" and the opponent chooses "scissors"
      Then I should see "Score: You, 1. Opponent1, 0"
      And I press "rock" and the opponent chooses "scissors"
      Then I should not see "You are the winner!"
      And I press "scissors" and the opponent chooses "paper"
      Then I should see "You won the game!"

    Scenario: Opponent1 wins in 1 round
      Given I am on the homepage to play "1" rounds
      And I press "paper" and the opponent chooses "scissors"
      Then I should see "Score: You, 0. Opponent1, 1"
      And I should see "Opponent1 won the game!"

    Scenario: Player wins in one round
      Given I am on the homepage to play "1" rounds
      And I press "rock" and the opponent chooses "scissors"
      Then I should not see "Round 0: Choose!"
      And I should see "You won the game!"


# Players can have names

    Scenario: Player has a name
      Given I am on the homepage with the name "Ptolemy" to play "3" rounds
      And I press "rock" and the opponent chooses "scissors"
      Then I should see "Score: Ptolemy, 1. Opponent1, 0"
      And I press "rock" and the opponent chooses "scissors"
      Then I should see "Score: Ptolemy, 2. Opponent1, 0"
      And I press "rock" and the opponent chooses "scissors"
      Then I should see "Score: Ptolemy, 3. Opponent1, 0"
      And I should see "Ptolemy won the game!"

    Scenario: I can enter my own name and start a game with defaults: round, 1. Opponent1's name, opponent.
      Given I am on the newgame page
      Then I should see "What's your name?"
      And I fill in "name" with "Ptolemy"
      Then I press "submit"
      And I press "rock" and the opponent chooses "scissors"
      Then I should see "Score: Ptolemy, 1. Opponent1, 0."

# More than two players.

    Scenario: Sudden death mode when two players have the target score.
      Given I am on the homepage with the name "Ptolemy" to play "3" rounds with "2" opponents
      And I press "paper" and the opponents choose "rock" and "rock" 
      Then I should see "Score: Ptolemy, 1. Opponent1, 0. Opponent2, 0"
      And I press "rock" and the opponents choose "paper" and "paper" 
      Then I should see "Score: Ptolemy, 1. Opponent1, 1. Opponent2, 1"
      And I press "paper" and the opponents choose "paper" and "rock"
      Then I should see "Score: Ptolemy, 2. Opponent1, 2. Opponent2, 1"
      And I press "paper" and the opponents choose "paper" and "rock" 
      Then I should see "Score: Ptolemy, 3. Opponent1, 3. Opponent2, 1"
      Then I should not see "won the game!"
      And I should see "SUDDEN DEATH!"
      And I press "paper" and the opponents choose "rock" and "rock"
      Then I should see "Ptolemy won the game!"


    





