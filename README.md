# Snake
Simple recreation of the classic game snake using the CLI. This project includes a very basic CLI game engine that could be used to implement other simple games.

# How to run?
Navigate into the project directory in your terminal. Be sure to have Ruby as well as the bundler gem installed. Run the command 'bundle install' inside the directory, this will install any necessary dependencies. When you are ready to run the game, run the command 'ruby bin/run'. The game will begin with a 3 second countdown.

# How to play?
Simple: control the snake's movement direction using the arrow keys. The objective is to consume as much food(@) as possible without crashing. The snake will move automatically approximately 5 times per second in increments of 1 space. If the snake ever comes in contact with itself or the surrounding walls, the game ends and exits back to the command line automatically. Pressing 'esc' will manually terminate the game as well.
