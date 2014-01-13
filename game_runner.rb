#!/usr/bin/env ruby
require_relative 'game_board'

game = GameOfLife::GameBoard.new File.open((ARGV[0] || 'spinner') + '.txt', 'r').each_line.reduce('', :+)
board_size = ARGV[1] || 20
number_lives = ARGV[2] || 1000
@last_gen_time = 0

(0..number_lives.to_i).each do |cnt|
  sleep [0, (0.2 - @last_gen_time)].max
  start_gen = Time.now
  life_s = game.next_life.to_s_size(-5,board_size.to_i)
  system 'clear'
  puts life_s
  @last_gen_time = Time.now - start_gen
  puts "life \##{cnt} created in #{@last_gen_time}"
end