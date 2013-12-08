require 'rspec'
require_relative 'cell'

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

  describe 'cell with no neighbors' do
    it 'should be dead' do
      neighbors = nil
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
