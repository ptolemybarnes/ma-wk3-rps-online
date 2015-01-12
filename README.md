Rock, Scissor, Paper.
=======================
by Ptolemy Barnes. 

## Synopsis
The Makers Academy Marketing Array ( MAMA ) have asked us to provide a game for them. Their daily grind is pretty tough and they need time to steam a little.

Your task is to provide a Rock, Paper, Scissors game for them so they can play on the web with the following features:

- The marketeer has to enter their name before the game
- The marketeer will be presented the choices (rock, paper and scissors)
- The marketeer can choose one option
- The game will choose a random option
- A winner will be declared

## Preamble
I wanted to approach this project with the concept of Minimum Viable Product in mind. What I realised through discussions with other students is that the MVP concept doesn't work very well when you try to plan out the sequence (skateboard --> scooter --> etc.) in advance. For this challenge, therefore, I will try to forego making decisions about what future iterations will look like.

- **Skateboard:** Web page where player can choose rock, scissor, or paper.
- **Bicycle:** Player can play multi-round games.
- **Motorbike** Can play with multiple computer opponents.

## Technologies Used

- Ruby
- Sinatra
- Cucumber
- RSpec

## Favourite Code Snippet

~~~
<% elsif @rps_game.sudden_death? %>
SUDDEN DEATH!
<% end %>
~~~


## Still to complete/refactor

- Multiplayer branch
- [ ]

## Takeaway

I was happy with how I had build my Rock Paper Scissor classes largely open to extension (from simple one round-game, to multi-round games, to multiplayer games). This allowed me to introduce new functionality to the back end as they developed within the context of Cucumber's BDD workflow. This reached a hard-limit, however, when it came to integrating multiple computer players with multiple human players. I found that because I had implemented players simply as strings of player names, there was no clean way of distinguishing between human players and computer players. Additionally, as my coach on this project pointed out, players could easily input the same name.

The takeaway from this is that if there is every any doubt about whether to turn responsibility over to a new class at the initial stages of Domain modelling, it is better to err on the side of caution rather than have to go through the painful process of remodelling later.







