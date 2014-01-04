require 'delegate'
require_relative 'cell'
require_relative 'neighbors'
require_relative 'rule'

module GameOfLife

  DEAD_BOARD_CELL = CellWithCoords.new(0,0,Cell.new(DEAD_CELL))

  class GameBoard

    attr_reader :board_alive

    def initialize(board_config = '')
      create_board(rows_from(board_config).enum_for(:each_with_index).collect {|row_config, row| columns_for row_config, row })
    end

    def create_board(rows)
      @board = rows
      @board_alive = @board.inject([]) {|cells, row| cells + row.select {|cell| cell.is_alive } }
    end

    def to_s_size(min = 0, max = 100)
      (min..max).inject('') do |board, row|
        row = (min..max).inject(board) do |row_cells, col|
          cell = @board_alive.find(lambda {GameOfLife::DEAD_BOARD_CELL}) do |cell|
            cell.row == row && cell.col == col
          end
          row_cells + cell.to_s
        end
        row + "\n"
      end
    end

    def to_s
      to_s_size
    end

    def [](row)
      return Columns.new(Array.new(columns, DEAD_BOARD_CELL)) if row < 0 || row >= @board.size
      @board[row]
    end

    def next_life
      create_board((0...rows).inject([]) do |rows, row_index|
        rows << Columns.new((0...columns).inject([]) do |cols, col_index|
          cell = self[row_index][col_index]
          neighbors_for = find_neighbors_for(row_index, col_index)
          cols << cell.next_life(neighbors_for)
        end)
      end)
      self
    end

    def active_dim(dim)
      ((find_min_max_dim(:min, dim, :-))..(find_min_max_dim(:max, dim, :+)))
    end

    def find_min_max_dim(min_max, dim, plus_minus)
      @board_alive.send(min_max, &compare_dim(dim)).send(dim).send(plus_minus,1)
    end

    def compare_dim(dim)
      lambda {|cell1, cell2| cell1.send(dim) <=> cell2.send(dim) }
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

    def columns_for(row_config, row)
      Columns.new row_config.chars.enum_for(:each_with_index).collect { |cell_state, col| CellWithCoords.new(row,col,Cell.new(state_for(cell_state))) }
    end

    def state_for(cell_representation)
      return ALIVE_CELL if ALIVE_CELL.to_s == cell_representation.upcase
      DEAD_CELL
    end

    def find_neighbors_for(row, col)
      Neighbors.new(@board_alive.select do |cell|
        cell.is_neighboring(:row, row) && cell.is_neighboring(:col, col) && cell.is_not_me(row, col)
      end)
    end

  end

end

class Columns < SimpleDelegator

  def [](index)
    return GameOfLife::DEAD_BOARD_CELL if index < 0 || index >= __getobj__.size
    __getobj__[index]
  end
end