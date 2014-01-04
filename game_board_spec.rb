require 'rspec'
require_relative 'game_board'
require_relative 'cell'
require_relative 'neighbors'

describe 'initial state of board' do

  before do
    @board = GameOfLife::GameBoard.new("X X\n X ")
  end

  describe 'temp new infinite board representation' do
    it 'active board should be 1 row before first live cell' do
      @board.active_dim(:row).include? -1
    end
    it 'active board should be 1 row after last live cell' do
      @board.active_dim(:row).include? 2
    end
    it 'active board should be 1 col before first live cell' do
      @board.active_dim(:col).include? -1
    end
    it 'active board should be 1 col after last live cell' do
      @board.active_dim(:col).include? 3
    end
  end

  describe 'next life' do
    it 'should generate a board representing the next state of lives' do
      @board.next_life.to_s.should == " X \n X \n"
    end

    it 'should handle block pattern' do
      @board = GameOfLife::GameBoard.new "    \n XX \n XX \n    "
      @board.next_life.to_s.should == "    \n XX \n XX \n    \n"
      @board.next_life.to_s.should == "    \n XX \n XX \n    \n"
    end

    it 'should handle the blinker pattern' do
      @board = GameOfLife::GameBoard.new "     \n     \n XXX \n     \n     "
      @board.next_life.to_s.should ==    "     \n  X  \n  X  \n  X  \n     \n"
      @board.next_life.to_s.should ==    "     \n     \n XXX \n     \n     \n"
    end

    it 'should handle the glider pattern' do
      @board = GameOfLife::GameBoard.new "          \n  X       \n   X      \n XXX      \n          \n          \n          \n"
      @board.next_life.to_s.should ==    "          \n          \n X X      \n  XX      \n  X       \n          \n          \n"
      @board.next_life.to_s.should ==    "          \n          \n   X      \n X X      \n  XX      \n          \n          \n"
      @board.next_life.to_s.should ==    "          \n          \n  X       \n   XX     \n  XX      \n          \n          \n"
      @board.next_life.to_s.should ==    "          \n          \n   X      \n    X     \n  XXX     \n          \n          \n"
    end
  end

  it 'should be built with cells representing the state in the config' do
    @board[0][0].is_alive.should == true
    @board[1][2].is_alive.should == false
  end

  it 'can be represented as a string' do
    @board.to_s.should == "X X\n X \n"
  end

  describe 'columns' do
    it 'should have live cells' do
      @board.columns_for("x",0)[0].is_alive.should == true
    end

    it 'should have dead cells' do
      @board.columns_for(" ", 0)[0].is_alive.should == false
    end
  end

  describe 'rows' do
    it 'should create live cell rows' do
      @board.rows_from("xxx\nxxx\nxxx\n").size.should == 3
    end

    it 'should create dead cell rows' do
      @board.rows_from("   \n   \n   \n").size.should == 3
    end

    it 'should create dead cell locations' do
      @board.rows_from("   ")[0].size.should == 3
    end
  end

  describe 'neighbors' do
    it 'should be able to find neighbors for a cell' do
      @board = GameOfLife::GameBoard.new("X X\n X \n   ")
      @board.find_neighbors_for(1,1).number_alive.should == 2
    end

    it 'should be able to find neighbors for a cell on the edge of the board' do
      @board = GameOfLife::GameBoard.new("X X\n X \nX  ")
      @board.find_neighbors_for(0,0).number_alive.should == 1
    end

    it 'should be able to find neighbors for a cell on the edge of the board' do
      @board = GameOfLife::GameBoard.new("X X\n X \nX  ")
      @board.find_neighbors_for(2,0).number_alive.should == 1
    end

    it 'should be able to find neighbors for a cell on the edge of the board' do
      @board = GameOfLife::GameBoard.new("X X\n X \nX  ")
      @board.find_neighbors_for(0,2).number_alive.should == 1
    end
  end
end