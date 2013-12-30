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
  ALIVE_CELL = CellState.new 'X'

  class Cell
    attr_accessor :state

    def initialize(state = nil)
      @state = state || GameOfLife::DEAD_CELL
    end

    def next_life(neighbors)
      Cell.new @state.next_state(neighbors)
    end

    def change_state(neighbors)
      @state = @state.next_state neighbors
      @listener.cell_is @state
    end

    def listen_for_state_change(listener)
      @listener = listener
      @listener.cell_is @state
    end

    def is_alive
      @state == GameOfLife::ALIVE_CELL
    end

    def to_s
      @state.to_s
    end
  end

end
