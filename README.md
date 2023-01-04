I want to modify the code to be like this
1. Monkeys randomly appear in holes on a sudden, one monkey, two monkeys or even three monkeys at the same time.
2. The order of monkey appearance is random.
3. Monkeys don't appear for a long time. They just show themselves for a short duration. Then, they hide themselves in holes.
4. As the monkeys are hit, the score of the player is increased.
5. When player hits wrong hole, player losses point.
6. Score of the player should be displayed.
Implementation:
1. Use 4 successive LEDs in your FPGA Board representing holes.
2. When LEDs are ON, monkeys appear.
3. Use pushbuttons to hit monkeys. Each pushbutton should be assigned to a certain LED.
4. Use 7-segment display for scoreboard.
5. Introduce degree of difficulty in your game, i.e. In the first level, the monkey's appearance is longer. As the difficulty level increases, monkey appearance duration decreases.
6. Set monkey appearance duration as random, i.e., monkeys can appear shorter or longer.
7. Introduce a password cheating game using binary switches. By activating password, special session starts and x2 or x3 scores are obtained when monkeys are hit. But this special session should be limited time.
8. display difficulty level, Game score, number of remaining lives on to a LCD or VGA screen
