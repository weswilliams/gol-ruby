require_relative 'game_board'

game = GameOfLife::GameBoard.new File.open((ARGV[0] || 'spinner') + '.txt', 'r').each_line.reduce('', :+)
board_size = ARGV[1] || 20
number_lives = ARGV[2] || 1000

(0..number_lives.to_i).each do |cnt|
  sleep 0.3
  system 'clear'
  puts game.next_life.to_s_size(0,board_size.to_i)
  puts "life \##{cnt}"
end