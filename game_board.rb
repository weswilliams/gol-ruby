module GameOfLife

  class GameBoard
    def initialize(board_config = "")
      @board = rows_from(board_config).collect {|row_config| columns_for row_config }
    end

    def to_s
      @board.inject('') {|board, row| board + row.inject('') {|row_cells, cell| row_cells + cell.to_s } + "\n" }
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

    def columns_for(row_config)
      row_config.chars.collect { |cell_state| Cell.new(state_for(cell_state)) }
    end

    def state_for(cell_representation)
      return GameOfLife::ALIVE_CELL if GameOfLife::ALIVE_CELL.to_s == cell_representation.upcase
      GameOfLife::DEAD_CELL
    end
  end

end
