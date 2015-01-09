Feature: Playing rock, paper, scissor
  In order to play rock, paper, scissor
  As a player who wants to resolve an argument
  I want to choose rock, paper, or scissor.

  Scenario: Choosing rock
    Given I am on the homepage
    And I press "rock" and the computer chooses "paper"
    Then I should see "The computer chose scissors. Rock wins!"

  Scenario: Choosing paper
    Given I am on the homepage
    And I press "paper" and the computer chooses "rock"
    Then I should see "The computer chose rock. Paper wins!"
    And I should not see "Rock wins!"

  Scenario: Choosing scissors
    Given I am on the homepage
    And I press "scissor"
    Then I should see "Scissor wins!"
    And I should not see "Rock wins!"
