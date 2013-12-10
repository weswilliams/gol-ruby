module GameOfLife

  class CellState
    def initialize state
      @state = state
    end
    def apply(rule, alive_neighbors)
      rule.apply alive_neighbors, self
    end
  end

  DEAD_CELL = CellState.new 'DEAD'
  ALIVE_CELL = CellState.new 'ALIVE'

  class Rule
    def initialize(cell_state, rule)
      @cell_state = cell_state
      @rule = rule
    end
    def apply(number_alive, current_state)
      @rule.call number_alive
    end
    def rule_cell_state
      @cell_state
    end
  end

  class AliveRule < SimpleDelegator
    def initialize(&rule)
      __setobj__ Rule.new(GameOfLife::ALIVE_CELL, rule)
    end
  end

  class DeadRule < SimpleDelegator
    def initialize(&rule)
      __setobj__ Rule.new(GameOfLife::DEAD_CELL, rule)
    end
  end

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
