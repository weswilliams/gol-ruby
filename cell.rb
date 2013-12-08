module GameOfLife

  class CellState

  end

  class Cell
    def changeState(neighbors)

    end

    def listenForStateChange(listener)
      @listener = listener
      @listener.cellIs GameOfLife::DEAD_CELL
    end
  end

  DEAD_CELL = CellState.new
end
