require_relative 'game_board'

game = GameOfLife::GameBoard.new "          \n  X       \n   X      \n XXX      \n          \n          \n          \n"

(0..20).each do
  sleep 0.5
  system 'clear'
  puts game.next_life
end