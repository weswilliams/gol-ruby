require_relative 'rule'

module GameOfLife

  class CellState
    def initialize state
      @state = state
    end
    def next_state(rules, alive_neighbors)
      (rules + [default_rule]).find { |rule| rule.apply(alive_neighbors, self) }.rule_cell_state
    end
    def default_rule
      Rule.new(self) {true}
    end
  end

  DEAD_CELL = CellState.new 'DEAD'
  ALIVE_CELL = CellState.new 'ALIVE'

  class Cell
    attr_accessor :state

    def initialize(state = nil)
      @state = state || GameOfLife::DEAD_CELL
    end

    def change_state(neighbors)
      @state = neighbors.determine_next_state @state
      @listener.cellIs @state
    end

    def listen_for_state_change(listener)
      @listener = listener
      @listener.cellIs @state
    end

    def is_alive
      @state == GameOfLife::ALIVE_CELL
    end
  end

end
