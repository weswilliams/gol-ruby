require 'rspec'
require_relative 'game_board'

describe 'initial state' do

  before do
    @board = GameOfLife::GameBoard.new
  end

  describe 'of columns' do
    it 'should have live cells' do
      @board.columns_for("x")[0].is_alive.should == true
    end
  end

  describe 'of rows' do
    it 'should create live cell rows' do
      @board.rows("xxx\nxxx\nxxx\n").size.should == 3
    end

    it 'should create dead cell rows' do
      @board.rows("   \n   \n   \n").size.should == 3
    end

    it 'should create dead cell locations' do
      @board.rows("   ")[0].size.should == 3
    end
  end

end