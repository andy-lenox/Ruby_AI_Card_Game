Using AI to Playtest and Author Card Games
Andrew Lenox

1. Intro

  In computer games, numbers drive the players actions. When Mario jumps, he does so according to the mechanics of the game. When you deal damage to a monster in World of Warcraft, you do so according to complicated formulas that happen behind the scenes. These formulas and mechanics are tweaked and updated in order to provide an optimal player experience that fades into the background. Computers allows the game mechanics to be intractably complex, making the game predictable, yet still mysterious to the game player. He can follow the rules, but not break them by figuring out all the ins and outs. In a board or card games, the computer cannot help reduce the intractable complexity. This means game designers who wish to create a board game must devise complex mechanics that are also easily computed. A board game designer must delicately balance a complex and interesting mechanical system of rules that both illicit a challenge from the player, without being so computationally difficult that the player is distracted from the experience.
	In 2006, inspired by other card games and our love of campy martial arts movies, my close friend and I decided to create our own card game. We had both played a lot of collectible deck building card games such as Magic the Gathering, Legend of the Five Rings, and Spycraft, and want to have the same kind of deck building mechanic as those games employ. One where you can select from a large pool of cards to strategically create a deck that fits your play strategy. Like campy martial arts movies of the 1970’s we wanted the game to be a fast paced showdown between two martial arts masters. The combination of the deck building mechanic and the theme would mean that players could create their own martial arts styles through their card and strategy choices.
 These design decisions led us to a core mechanic we believed we could build on to create the rest of our game. From this core mechanic we created all kinds of rules variants, custom cards, and different card types that built on our central fast-paced mechanic, but we were building all these on the assumption that our central mechanic was simple enough to grasp quickly, while being complex enough to be interesting to play. I had doubts about this assumption early on in the play testing of our game. I had no explanation for why, but whenever we played the game felt deterministically random. It felt like the whole game was decided by the shuffle of the cards, and that no amount of strategic decision could change the outcome of the game. The only method we had to determine this was large amounts of play-testing.
Rapid prototyping and play-testing of a card game is difficult as it involves printing and re-printing cards over and over. Every rules change can have large sweeping effects on the text of cards and require more paper, time, and effort than is really practical. For this reason I wanted to create a program where I could run the game and iterate through design decisions quickly, seeing immediately the results of those decisions in order to help make the game a better player experience. With a game running on a computer, I would also be able to create AI code that would play the game automatically based on any parameters I choose. With multiple AI’s I could run the game hundreds of times in a row very quickly while collecting data about the outcomes of these games. This could help determine optimal strategies for the game, and even answer some of my earlier questions. Is this game really a deterministic roll of the proverbial dice, or are there enough strategic and tactical options for the player to make this game actually fun?

2. The Game

	We devised many different versions of rules for our game, and built many strange and different mechanics on top of those rules, but throughout all versions of the game, the core mechanics stayed the same. Because of the complexity and fluidity of the additional rules, I have omitted everything but the core mechanics of the game in this project. This is because of two reasons. First, the additional rules added a lot of complexity to the game that would be difficult to code up. Second, if throughout this analysis the core mechanics of the game turn out not to be sound, all the other mechanics would also have to be rewritten.
	The rules of the game are as follows.

To begin play, each player shuffles their decks and draws 5 cards. The player with the highest quickness has the initiative. In this program, the first player is just predetermined as there is no difference between players.

Initiative: The player who's turn it is to attack. In the beginning of the round if both players have equal quickness then both players draw the top card of their deck, the highest # gains initiative. In case of a tie keep drawing cards till the tie is broken. Whenever a player gains initiative, if there are cards in your play pile, move them to your discard pile.

Discard Pile: Whenever a card is activated it moves to the discard pile. Whenever a player gains initiative, you move all cards from your play pile to your discard pile. If at any time you need to take a card from your deck and you don't have enough cards, shuffle your discard pile. Your discard pile is now your deck.

To attack put a card in the play pile in front of you on the table. This may also be called playing a card.

Attack: The character with initiative plays a card. The # of the card determines the target number for the opponent.

Play: To play a card, place it on the table in front of you in the play pile.

Play Pile: The pile of cards in front of you where cards are played. Whenever a player gains initiative move your play pile to your discard pile before that player plays a card; Ties go to the player who didn't play the last card.

Now, the player with the highest quickness should have a card in front of him on the table that he has just played and either player may have cards in their discard piles from reacting to the cards that had been played. The number on the card in front of the player is the other players target number After an attack has been made, the other player has a chance to counterattack or block.

Now that the next player has a target number, he must play a card in response to this target number. If the player plays a card that is plus or minus 1 away from the target number, his card is a counter attack.

Counterattack: When a card is played after an attack that is + or - one from the value of the attack, it is considered a counter attack. After a counter attack is played, treat it in every way like an attack on the next player.

After a counter attack this new card becomes the target number for the next player. Play continues like this until one character blocks or hits.

Block: When a player plays a card that matches the target number, it is considered a block. When a player blocks the player draws one card and play continues.

Hit: When a player plays a card that neither blocks nor counter attacks a previously played card, that player is hit. When a player is hit -
    1: He takes damage equal to the difference between the number on the card played and the target number plus the strength of his opponent. In our simulation the strength of each player will be set to 0 to facilitate longer games with more generated data.
    2: He draws cards up to his maximum hand size, or draws the cards equal to the value of his quickness trait. Again, in the simulation no players have quickness traits, so they will just draw to their maximum hand size.

example: John plays a card with target number 5. Edward has only has a 1 and a 2 in his hand. He plays the 2. This is neither a counterattack nor a block, therefore Edward takes damage equal to the difference between the target number and the number played (5 - 2 = 3) plus the John's strength ( 2 + 3 = 5 ). Edward takes 5 damage and draws up to his maximum hand size. 

Empty Hand: Any time you have no cards in your hand, you have an empty hand. If you have an empty hand and you must play a card, you play the top card of your deck directly into the play pile.

Play continues in this pattern until one player wins the round. A round ends when 40 cards have been moved into the damage pile.

Damage: When a player is damaged he must take a number of cards off the top of his deck and put them in the damage pile. The number of cards is determined by the card that damaged him. See the text of the card or the hit rule for more information.

A whole game consists of 3 rounds.  The first player to win two rounds wins the game.

Round: A round takes place between the first attack and the moment when the first player runs out of cards to move from their deck to their damage pile. The player who runs out of cards in their deck is the loser of the round. The other player is the winner of the round. Reactions may be played to the end of a round.

Game: The first player to win 2 rounds wins the game.

The concept of a game and rounds, for the purposes of the simulation, will be discarded and only rounds will be considered. This way we can view each run of the game as any number of rounds we see fit to collect the data needed.

3. Approach to AI

	The goal of this project is to determine, using AI whether the core mechanic of our game is deterministic or responsive to higher levels of strategy and play. If the game has a predictable strategy that always wins, it may not be any fun. Pitting different AI strategies against one another we can collect data that will tell us this. My approach will be to take an iterative approach to developing different “bots” to play the game. Each bot will use more sophisticated means of determining its next move.

In order to figure this out we need a baseline to judge from. Our first approach will be to establish a baseline of win percentages. In a deterministic game based on random distributions, it should follow that if both players play random cards from their randomly shuffled decks, there should be a roughly even distribution of wins to losses.

Player 1 wins: 5333, Player 2 wins: 4667
Player 1 wins: 5326, Player 2 wins: 4674
Player 1 wins: 5322, Player 2 wins: 4678

For some reason, player 1 has a consistent 54% win percentage. Over this many runs of the program, the win percentages should have been even. There might be something affecting these percentages however. In many board games and card games, there is some penalty for going first because going first has some inherent advantage. In our case, the first player gets to play any card he wishes from his hand without having to react to any previously played card because no card has yet been played.

Seeding the play area with 3’s
Player 1 wins: 4875, Player 2 wins: 5125
Player 1 wins: 4830, Player 2 wins: 5170
Player 1 wins: 4766, Player 2 wins: 5234
P1 48.2% Win Percentage

Player 1 starts with one fewer cards in hand.
Player 1 wins: 5341, Player 2 wins: 4659
Player 1 wins: 5372, Player 2 wins: 4628
Player 1 wins: 5447, Player 2 wins: 4553

	As we will see throughout the research, the problem of the first turn advantage does not go away so easily. The random bot will be used as a base line for performance increases of individual bots throughout the study. The rest of the bots use varying strategies as follows.

Blocker Bot

The Blocker bot is a bot that plays a card that matches the card in the play area if it happens to have one in its hand, otherwise it plays a random card from it’s hand. This is not a horribly interesting robot, but it’s limited intelligence should be enough to beat a purely random opponent most of the time.

Best Bot

The best bot takes slightly more of the game rules into consideration when playing a card. Like the blocker bot, it too blocks when able. Unlike the blocker bot, it also checks to see if it has a card that is within one of the previously played card. This will allow the bot to counter-attack when possible. When it is not able to do either actions, it will play a random card from its hand.

Better Bot

Like the best bot, this bot will block or counter attack when able, but instead of playing a random card when it can’t, it will try to reduce the damage taken. It does this by always playing the card numerically closest to the last played card. 

Future Bot

Originally my idea for future bot was to use a search tree and the minimax algorithm to search through possible play states and determine the correct card to play. The problem with this in this game is that we don’t have full information of what our opponent will be able to play as his hand is concealed from us. In the minimax algorithm, you use information about the best possible move for your opponent to determine what he will do, then you use that likely move to derive which path down the search tree you will take. In this game the best move is to always match the last played card if you can since it nets you an additional card, increasing your chances of being able to block or counter attack their next card. This makes large parts of the minimax search not useful for our problem.

Next an optimal play in our game will be one that does damage to our opponent. Our only metric for how likely we are to do damage to our opponent is how many cards he has in his hand. This means an optimal play is one that depletes his had size without depleting our own. So in other words, a bot acting optimally will always block when able. Next an optimal play in our game will be one that reduces the likelihood that we take a hit. In order to avoid hits, we need the best probabilistic spread of cards we can get in order to maximize our chances of blocking or counter attacking. We’ve already said that blocking will be optimal, but also the more times we are able to play a card that blocks or counter attacks, the better off we are. This means we want as many long strings of plays as we can get. We want to use our entire hand of cards against our opponent without being hit. The best way to maximize this is to plan a path.

Because of the linear nature of the cards in our hand, Path planning is only a matter of determining one of two directions; up or down the number line. Say for instance our opponent has played a target number 3 and our hand contains a 0,1,2 and a 4. We could play a 2 or a 4 and not take damage from this play. If we play a 4, and assume that the opponent will play optimally, he will return the favor by also playing a 4. What then? We have no choice but to take damage. If, however, we played the 2, and the other player plays optimally, we can then play a 1, and a afterwards. This means our opponent has to make 4 optimal plays in order to do damage to us.

Our opponent also has no information about what is in our hand, so he would not know that playing sub-optimally would cause us to take a hit and cause him to play fewer cards. The lack of information in this game has the tendency to create less interesting situations, something that will certainly be revisited in my conclusions.

Since we know, in our example, that if we go down the number line with our play, it will leave us with more future options, we can assume this is optimal. Future bot uses this information to weigh the cards in our hand. For every card above the target card he increases a counter by one. For every counter below the target card, he decreases the counter by one. If the counter is greater than zero he plays up the number line, and if it is less he plays down.

This version of future bot is not perfect to our concept however. This bot doesn’t take into consideration consecutive numbers. So take for instance a hand like this: [0,0,0,5,6]. The original future bot would weigh this as being down the number line. It would still correctly play a 5 since this bot first tries to play a card that won’t get it into trouble, but it’s assessment of its hand is incorrect. The incorrect assessment doesn’t matter though. Because an optimal play always starts with a block, you will never have a situation where there is a strange path through the card plays. You’ll always deplete a stack of like numbers first, leaving you with a clear delineation between up and down. If you have the same number of ups as downs, it doesn’t matter which you play.

Damage Bot

Damage bot is like its predecessors in that it blocks and counter attacks when possible, with the exception that it tries to exploit the endpoints of the number to maximize the damage done to it’s opponent. Damage bot operates on two principals of the game. First that the greater the difference between the cards played, the greater the damage. For instance, if I play a 2 and my opponent plays a 4, he takes the difference, two, damage. If I can find out how to play cards that are ‘further away’ than his cards I will maximize damage to him. 

For instance, in a a scenario where the opponent plays a 1, but has no cards left in his hand, if I have a 0 and a 2, I should play a 0 because it is the card that lies furthest from all other possible cards on the number line. The other aspect of the game being exploited here by damage bot is that 0 and 6 have fewer cards that can respond to them because they lie on the endpoints. Each has only 2 cards in the deck that can respond to them, whereas all other numbers have 3.


4. Technical Discussion

The program used to do simulations was written in the ruby scripting language. The game, as written is capable of using human player input or the input of bots. Game initialization determines the mode of the game include human or robot players and the bot types used in the game. You can also alter the number of times the game can be run consecutively. The program is also set up to write stats various game states out to a file. Automated unit tests were written to ensure correct execution and to allow for quick and easy refactoring.

All permutations of 2 player games were tried with all the different bot types. Each permutation played 1000 simulated games. It was also important to record the win percentages of each bot as the first player and second player to analyze any advantage given by going first. The number of hits and blocks was recorded for each bot as well. All stats were written as comma separated value files and loaded into a spreadsheet program for analysis. The spread sheet and source code are attached to this paper for 

3 Conclusions

The goal of this project was to use AI and automation to analyze the game and improve upon it based on those findings. The findings have lead to a number of good suggestions for changing game play, but a few troubling findings also exist that put the viability of the game into question.

Going First

The first conclusion is that play order has a non-trivial effect on the entire game. This is most noticeable from the stat blocks.
Fig1: Future Bot Stats

Notice when going second, in almost every case, future bot had more hits and more blocks overall. 

Fig2: Best Bot Win Percentage

Again, when looking at win percentage for best bot, going first was only ever an advantage against the random bot. In other bot’s stats the conclusions are similar. The only time when going first was any statistical advantage was when playing against the random bot, or when the future bot played against the future bot.

This is interesting because the hypothesis was that since the first player gets to play a card into an empty play area with no consequences, he would have a slight advantage from that first turn. However, going first may be a disadvantage because as the second player, you have a chance to block. If the first player goes first with no chance of blocking, and the second player goes after him and blocks, this leaves the second player with 5 cards in hand and the first player with 4. He is essentially down two cards because he cannot possibly block.

There are a number of solutions we could employ to fix this. We could allow the first player an additional card in hand at the beginning of the game, A neutral card could be seeded into the play area, or the second player could start with one fewer cards. These solutions all probably lead to their own back and forth balancing act of disregarding the advantage of going second. My final solution would be to have the game play out over a number of shorter rounds. Some new criteria in the game would determine who strikes first in each round. Letting the players decide the value of going first or second based on their hand makes for a more interesting and strategic game.

Future Bot

The first troubling sign came from the results of future bot. This was by far the smartest of the bots, capable of plotting out longer strings of plays in order to stay afloat longer than the other bots. It didn’t perform well though. Simpler algorithms were able to play the game better than the future bot which suggests that the game does decline into determinism at some point. 

Stats

The most troubling conclusion is based on the stats. When we exclude the blocker bot and the random bot from our statistics, we get a variance for each stat of about 0.5. This means that the number of hits in a game, regardless of strategy or the winner, is always around 12. This makes for a rather boring game. This data suggests that hits and blocks cannot be prevented in any way and the only control a player has over the game is the amount of damage he deals or is dealt. This conclusion is also supported by the win percentages of the damage bot. That bot’s strategy was to always block when able, but to try to maximize damage when counter-attacking.

The reason this is the most troubling conclusion is that it suggests that the game needs a major ground up overhaul of the rules. Card games should be full of interesting choices. If there is one simple strategy that wins despite others using more complex analysis of the game state, it means there aren’t interesting choices. You go through the motions until the game ends and a winner is declared. 

Final Thoughts

The final results have suggested that the game as it stands isn’t much of a game. The act of throwing down cards at a fast and furious pace is still fun, but there are no interesting decisions to make when you do so. In the next iteration of this game, these deficits will be addressed. First, the game as is should be a component or a smaller phase of a larger game. If players have the chance to dig through their deck and set up the cards in their hand before engaging in back and forth round of attacks, this could remedy all the issues currently in the game. 

Another solution would be to increase the amount of available information to players. If both players played with some of their hands visible to the other player, path planning would become more interesting. Then, with some cards not visible, the element of surprise would still exist. Both of these changes could be combined to make for a much more complex and satisfying game.


4. References:

Lenox, Andrew T., and Toby Dewley. "Martial Arts Cardgame Rulebok." Web. <https://docs.google.com/Doc?docid=0ATQFsm1iPCeNZDUycGJrN18yNmMycDJjMmNt&hl=en&authkey=CIGe2LAI>.


Appendix: See attached PDF For Code