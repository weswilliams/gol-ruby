require_relative 'rule'

module GameOfLife

  class CellState
    include GameOfLife
    attr_reader :state
    def initialize state
      @state = state
    end
    def next_state(alive_neighbors)
      (rules + [default_rule]).find { |rule| rule.apply(alive_neighbors, self) }.rule_cell_state
    end
    def default_rule
      Rule.new(self) {true}
    end
    def ==(other_state)
      other_state.state == @state
    end
  end

  class DeadState < SimpleDelegator
    def initialize
      __setobj__ CellState.new 'DEAD'
    end
  end

  class AliveState < SimpleDelegator
    def initialize
      __setobj__ CellState.new 'ALIVE'
    end
  end

  DEAD_CELL = DeadState.new
  ALIVE_CELL = AliveState.new

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
