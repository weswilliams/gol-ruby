require_relative 'game_board'

game = GameOfLife::GameBoard.new "          \n  X       \n   X      \n XXX      \n          \n          \n          \n"

(0..100).each do
  sleep 0.2
  system 'clear'
  puts game.next_life.to_s_size(0,20)
end