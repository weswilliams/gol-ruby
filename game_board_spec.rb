require 'rspec'
require_relative 'game_board'

describe 'initial state of board' do

  before do
    @board = GameOfLife::GameBoard.new("X X\n X ")
  end

  it 'should be built with initial number of rows from config state' do
    @board.rows.should == 2
  end

  it 'should be built with initial number of columns from config state' do
    @board.columns.should == 3
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
      @board.columns_for("x")[0].is_alive.should == true
    end

    it 'should have dead cells' do
      @board.columns_for(" ")[0].is_alive.should == false
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

  describe 'next life' do
    it 'should be able to find neighbors for a cell' do
      @board = GameOfLife::GameBoard.new("X X\n X \n   ")
      @board.find_neighbors_for(1,1).number_alive.should == 2
    end

    it 'should be able to find neighbors for a cell on the edge of the board' do
    #  next test to implement
    end
  end
end