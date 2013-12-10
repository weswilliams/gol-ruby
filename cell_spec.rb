require 'rspec'
require_relative 'cell'
require_relative 'neighbors'

class CellStateListener
  attr_accessor :current_state
  def cellIs(state)
    @current_state = state
  end
end

def alive_neighbors(cnt = 1)
  neighbors = []
  (1..cnt).each { neighbors << GameOfLife::Cell.new(GameOfLife::ALIVE_CELL) }
  GameOfLife::Neighbors.new neighbors
end

describe 'game of life cells' do

  before do
    @cell_state_listener = CellStateListener.new
  end

  describe 'dead cells' do
    before do
      @cell = GameOfLife::Cell.new
      @cell.listen_for_state_change @cell_state_listener
    end

    it 'should be dead on creation' do
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
      @cell.is_alive.should == false
    end

    it 'should stay dead with no alive neighbors' do
      @cell.change_state alive_neighbors 0
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

    it 'should stay dead with 1 alive neighbor' do
      @cell.change_state alive_neighbors 0
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

    it 'should come alive if it has 2 live neighbors' do
      @cell.change_state alive_neighbors 2
      @cell_state_listener.current_state.should == GameOfLife::ALIVE_CELL
    end

    it 'should come alive if it has 3 live neighbors' do
      @cell.change_state alive_neighbors 3
      @cell_state_listener.current_state.should == GameOfLife::ALIVE_CELL
    end
  end

  describe 'alive cells' do
    before do
      @cell = GameOfLife::Cell.new GameOfLife::ALIVE_CELL
      @cell.listen_for_state_change @cell_state_listener
    end

    it 'can be created ALIVE' do
      @cell_state_listener.current_state.should == GameOfLife::ALIVE_CELL
      @cell.is_alive.should == true
    end

    it 'should die with no alive neighbors' do
      @cell.change_state alive_neighbors 0
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

    it 'should die with 1 alive neighbor' do
      @cell.change_state alive_neighbors 1
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end

    it 'should stay alive with 2 neighbors' do
      @cell.change_state alive_neighbors 2
      @cell_state_listener.current_state.should == GameOfLife::ALIVE_CELL
    end

    it 'should stay alive with 3 neighbors' do
      @cell.change_state alive_neighbors 3
      @cell_state_listener.current_state.should == GameOfLife::ALIVE_CELL
    end

    it 'should die with > 3 alive neighbors due to over crowding' do
      @cell.change_state alive_neighbors 4
      @cell_state_listener.current_state.should == GameOfLife::DEAD_CELL
    end
  end

end
