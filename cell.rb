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
      (rules + [default_rule]).find { |rule| rule.apply?(neighbors, self) }.rule_cell_state
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
  ALIVE_CELL = CellState.new 'O'

  class Cell
    attr_reader :row, :col
    attr_accessor :state

    def initialize(row=0,col=0,state=nil)
      @state = state || GameOfLife::DEAD_CELL
      @row = row
      @col = col
    end

    def next_life(neighbors)
      Cell.new @row, @col, @state.next_state(neighbors)
    end

    def is_not_me(row, col)
      !(self.row == row && self.col == col)
    end

    def is_alive
      @state == GameOfLife::ALIVE_CELL
    end

    def to_s
      @state.to_s
    end

    def ==(another_cell)
      @row == another_cell.row && @col == another_cell.col
    end
  end

end
