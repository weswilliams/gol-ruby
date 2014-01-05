require 'rspec'
require_relative 'cell'
require_relative 'neighbors'

class CellStateListener
  attr_accessor :current_state
  def cell_is(state)
    @current_state = state
  end
end

def alive_neighbors(cnt = 1)
  neighbors = []
  (1..cnt).each { neighbors << GameOfLife::CellWithCoords.new(0,0,GameOfLife::ALIVE_CELL) }
  GameOfLife::Neighbors.new neighbors
end

describe 'game of life' do

  describe 'dead cells' do
    before do
      @cell = GameOfLife::CellWithCoords.new(0,0,GameOfLife::DEAD_CELL)
    end

    it 'should be represented as a space' do
      @cell.to_s.should == ' '
    end

    it 'should be dead on creation by default' do
      @cell.is_alive.should == false
    end

    it 'should stay dead with < 3 live neighbors' do
      @cell.next_life(alive_neighbors(2)).is_alive.should == false
    end

    it 'should come alive with 3 live neighbors' do
      @cell.next_life(alive_neighbors(3)).is_alive.should == true
    end
  end

  describe 'alive cells' do
    before do
      @cell = GameOfLife::CellWithCoords.new 0,0, GameOfLife::ALIVE_CELL
    end

    it 'should be represented as a X' do
      @cell.to_s.should == GameOfLife::ALIVE_CELL.to_s
    end

    it 'can be created alive' do
      @cell.is_alive.should == true
    end

    it 'should die with no live neighbors' do
      @cell.next_life(alive_neighbors(0)).is_alive.should == false
    end

    it 'should die with 1 live neighbor' do
      @cell.next_life(alive_neighbors(1)).is_alive.should == false
    end

    it 'should stay alive with 2 live neighbors' do
      @cell.next_life(alive_neighbors(2)).is_alive.should == true
    end

    it 'should stay alive with 3 live neighbors' do
      @cell.next_life(alive_neighbors(3)).is_alive.should == true
    end

    it 'should die with > 3 alive neighbors due to over crowding' do
      @cell.next_life(alive_neighbors(4)).is_alive.should == false
    end
  end

end
