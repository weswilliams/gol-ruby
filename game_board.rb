module GameOfLife

  class GameBoard
    def rows(board_config)
      board_config.split("\n")
    end

    def columns_for(row_cells)
      row_cells.chars.collect { |cell| Cell.new(state_for(cell)) }
    end

    def state_for(cell_representation)
      return GameOfLife::ALIVE_CELL if "X" == cell_representation.upcase
      GameOfLife::DEAD_CELL
    end
  end

end
