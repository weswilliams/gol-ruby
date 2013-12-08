module GameOfLife

  class CellState

  end

  DEAD_CELL = CellState.new
  ALIVE_CELL = CellState.new

  class Cell
    attr_accessor :state

    def initialize(state = nil)
      @state = state || GameOfLife::DEAD_CELL
    end

    def changeState(neighbors)
      @state = neighbors.determine_next_state
      @listener.cellIs @state
    end

    def listenForStateChange(listener)
      @listener = listener
      @listener.cellIs @state
    end
  end

end
