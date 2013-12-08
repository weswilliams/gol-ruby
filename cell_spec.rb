require 'rspec'
require_relative 'cell'
require_relative 'neighbors'

class CellStateListener
  attr_accessor :current_state
  def cellIs(state)
    @current_state = state
  end
end

describe 'game of life cells' do

  before do
    @cell = GameOfLife::Cell.new
    @cell_state_listener = CellStateListener.new
    @cell.listenForStateChange @cell_state_listener
  end

  describe 'cell with < 2 alive neighbors' do
    it 'dead cell should stay dead' do
      neighbors = GameOfLife::Neighbors.new
      @cell.changeState neighbors
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

    it 'alive cell should die' do
      @cell = GameOfLife::Cell.new GameOfLife::ALIVE_CELL
      @cell.listenForStateChange @cell_state_listener
      neighbors = GameOfLife::Neighbors.new
      @cell.changeState neighbors
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end
  end

  describe 'new cell creation' do

    it 'should be dead' do
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

  end

end
