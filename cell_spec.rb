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
    @neighbors = GameOfLife::Neighbors.new
    @cell_state_listener = CellStateListener.new
  end

  describe 'dead cells' do
    before do
      @cell = GameOfLife::Cell.new
      @cell.listen_for_state_change @cell_state_listener
    end

    it 'should be dead on creation' do
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

    it 'should stay dead with < 2 alive neighbors' do
      @cell.change_state @neighbors
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

  end

  describe 'alive cells' do
    before do
      @cell = GameOfLife::Cell.new GameOfLife::ALIVE_CELL
      @cell.listen_for_state_change @cell_state_listener
    end

    it 'can be created ALIVE' do
      @cell_state_listener.current_state.should == GameOfLife::ALIVE_CELL
    end

    it 'should die with < 2 alive neighbors' do
      @cell = GameOfLife::Cell.new GameOfLife::ALIVE_CELL
      @cell.listen_for_state_change @cell_state_listener
      @cell.change_state @neighbors
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

  end

end
