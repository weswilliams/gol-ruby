require 'rspec'
require_relative 'game_board'
require_relative 'cell'
require_relative 'neighbors'

def replace_with_live_state(pattern)
  pattern.gsub 'X', GameOfLife::ALIVE_CELL.to_s
end

describe 'initial state of board' do

  before do
    @board = GameOfLife::GameBoard.new("X X\n X ")
  end

  describe 'next life' do
    it 'should handle and empty board' do
      @board = GameOfLife::GameBoard.new ''
      @board.next_life.to_s.strip.should == ''
    end

    it 'should generate a board representing the next state of lives' do
      @board.next_life.to_s_size(0,2).should == replace_with_live_state(" X \n X \n   \n")
    end

    it 'should handle block pattern' do
      @board = GameOfLife::GameBoard.new "    \n XX \n XX \n    "
      @board.next_life.to_s_size(0,3).should == replace_with_live_state("    \n XX \n XX \n    \n")
      @board.next_life.to_s_size(0,3).should == replace_with_live_state("    \n XX \n XX \n    \n")
    end

    it 'should handle the blinker pattern' do
      @board = GameOfLife::GameBoard.new "     \n     \n XXX \n     \n     "
      @board.next_life.to_s_size(0,5).should ==    replace_with_live_state("      \n  X   \n  X   \n  X   \n      \n      \n")
      @board.next_life.to_s_size(0,5).should ==    replace_with_live_state("      \n      \n XXX  \n      \n      \n      \n")
    end

    it 'should handle the glider pattern' do
      @board = GameOfLife::GameBoard.new "          \n  X       \n   X      \n XXX      \n          \n          \n          \n"
      @board.next_life.to_s_size(0,5).should ==    replace_with_live_state("      \n      \n X X  \n  XX  \n  X   \n      \n")
      @board.next_life.to_s_size(0,5).should ==    replace_with_live_state("      \n      \n   X  \n X X  \n  XX  \n      \n")
      @board.next_life.to_s_size(0,5).should ==    replace_with_live_state("      \n      \n  X   \n   XX \n  XX  \n      \n")
      @board.next_life.to_s_size(0,5).should ==    replace_with_live_state("      \n      \n   X  \n    X \n  XXX \n      \n")
    end
  end

  it 'can be represented as a string' do
    @board.to_s_size(0,2).should == replace_with_live_state("X X\n X \n   \n")
  end

end