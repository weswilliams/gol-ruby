require 'delegate'
require_relative 'rule'

module GameOfLife

  class CellState
    include GameOfLife
    attr_reader :state
    def initialize state
      @state = state
    end
    def next_state(neighbors)
      (rules + [default_rule]).find { |rule| rule.apply(neighbors, self) }.rule_cell_state
    end
    def default_rule
      Rule.new(self) {true}
    end
    def ==(other_state)
      other_state.state == @state
    end
    def to_s
      @state
    end
  end

  DEAD_CELL = CellState.new ' '
  ALIVE_CELL = CellState.new '0'

  class Cell
    attr_accessor :state

    def initialize(state = nil)
      @state = state || GameOfLife::DEAD_CELL
    end

    def next_life(neighbors)
      Cell.new @state.next_state(neighbors)
    end

    def is_alive
      @state == GameOfLife::ALIVE_CELL
    end

    def to_s
      @state.to_s
    end
  end

  class CellWithCoords < SimpleDelegator
    attr_reader :row, :col

    def initialize(row=0,col=0,cell=nil)
      super(cell)
      @row = row
      @col = col
    end

    def next_life(neighbors)
      CellWithCoords.new @row, @col, __getobj__.next_life(neighbors)
    end

    def is_not_me(row, col)
      !(self.row == row && self.col == col)
    end

    def is_neighboring(row_or_col, index)
      (0..1).include? (index - self.send(row_or_col)).abs
    end

  end

end
