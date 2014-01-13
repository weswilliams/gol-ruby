require 'rspec'
require_relative 'cell'
require_relative 'neighbors'

def alive_neighbors(cnt = 1)
  neighbors_dbl = double(GameOfLife::Neighbors.class)
  neighbors_dbl.stub(:number_alive) { cnt }
  neighbors_dbl
end

describe 'game of life' do

  describe 'cell equality' do
    it 'should be equal with same row and col' do
      cell1 = GameOfLife::Cell.new 0, 0, GameOfLife::DEAD_CELL
      cell2 = GameOfLife::Cell.new 0, 0, GameOfLife::ALIVE_CELL
      (cell1 == cell2).should == true
    end

    it 'should not be equal with a different row' do
      cell1 = GameOfLife::Cell.new 0, 0, GameOfLife::DEAD_CELL
      cell2 = GameOfLife::Cell.new 1, 0, GameOfLife::ALIVE_CELL
      (cell1 == cell2).should == false
    end

    it 'should not be equal with a different col' do
      cell1 = GameOfLife::Cell.new 0, 0, GameOfLife::DEAD_CELL
      cell2 = GameOfLife::Cell.new 0, 1, GameOfLife::ALIVE_CELL
      (cell1 == cell2).should == false
    end
  end

  describe 'dead cells' do
    before do
      @cell = GameOfLife::Cell.new(0,0,GameOfLife::DEAD_CELL)
    end

    it 'should be represented as a space' do
      @cell.to_s.should == ' '
    end

    it 'should be dead on creation by default' do
      @cell.is_alive?.should == false
    end

    it 'should stay dead with < 3 live neighbors' do
      @cell.next_life(alive_neighbors(2)).is_alive?.should == false
    end

    it 'should come alive with 3 live neighbors' do
      @cell.next_life(alive_neighbors(3)).is_alive?.should == true
    end
  end

  describe 'alive cells' do
    before do
      @cell = GameOfLife::Cell.new 0,0, GameOfLife::ALIVE_CELL
    end

    it 'should be represented as a X' do
      @cell.to_s.should == GameOfLife::ALIVE_CELL.to_s
    end

    it 'can be created alive' do
      @cell.is_alive?.should == true
    end

    it 'should die with no live neighbors' do
      @cell.next_life(alive_neighbors(0)).is_alive?.should == false
    end

    it 'should die with 1 live neighbor' do
      @cell.next_life(alive_neighbors(1)).is_alive?.should == false
    end

    it 'should stay alive with 2 live neighbors' do
      @cell.next_life(alive_neighbors(2)).is_alive?.should == true
    end

    it 'should stay alive with 3 live neighbors' do
      @cell.next_life(alive_neighbors(3)).is_alive?.should == true
    end

    it 'should die with > 3 alive neighbors due to over crowding' do
      @cell.next_life(alive_neighbors(4)).is_alive?.should == false
    end
  end

end
