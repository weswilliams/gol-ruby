module GameOfLife

  class GameBoard
    def initialize(board_config = "")
      @board = rows_from board_config
      @board.collect! {|row_cells| columns_for row_cells }
    end

    def [](index)
      @board[index]
    end

    def rows
      @board.size
    end

    def columns
      @board[0].size
    end

    def rows_from(board_config)
      board_config.split("\n")
    end

    def columns_for(row_cells)
      row_cells.chars.collect { |cell| Cell.new(state_for(cell)) }
    end

    def state_for(cell_representation)
      return GameOfLife::ALIVE_CELL if GameOfLife::ALIVE_CELL.to_s == cell_representation.upcase
      GameOfLife::DEAD_CELL
    end
  end

end
