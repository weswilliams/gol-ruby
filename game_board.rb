require 'delegate'
require_relative 'cell'
require_relative 'neighbors'
require_relative 'rule'

module GameOfLife

  DEAD_BOARD_CELL = Cell.new(0,0,DEAD_CELL)

  class GameBoard

    attr_reader :board_alive

    def initialize(board_config = '')
      create_board(rows_from(board_config).enum_for(:each_with_index).collect {|row_config, row|
        columns_for row_config, row })
    end

    def to_s_size(start_index = 0, max_dim = 100)
      index_range(max_dim, start_index).inject('') { |board, row|
        row_string(board, max_dim, start_index, row) + "\n" }
    end

    def to_s
      to_s_size
    end

    def next_life
      create_board(live_cells_and_neighbors.collect { |cell|
        cell.next_life(find_neighbors_for(cell.row, cell.col))
      })
      self
    end

    private

    # to_s helpers
    def index_range(max_dim, start_index)
      (start_index..(start_index+max_dim))
    end

    def row_string(board_string, max_dim, start_index, row)
      index_range(max_dim, start_index).inject(board_string) { |row_cells, col|
        row_cells + find_cell_at(row, col).to_s }
    end

    def find_cell_at(row, col)
      @board_alive.find(lambda { Cell.new(row, col, DEAD_CELL) }) { |cell| cell.row == row && cell.col == col }
    end

    # next life helpers
    def live_cells_and_neighbors
      uniq_cells(@board_alive + @board_alive.inject([]) { |cells, cell|
        cells + find_neighbors_for(cell.row, cell.col) })
    end

    def uniq_cells(non_uniq_cells)
      non_uniq_cells.inject([]) { |cells, cell|
        cells << cell if not cells.find { |existing| existing == cell }
        cells
      }
    end

    def find_neighbors_for(row, col)
      Neighbors.new(@board_alive, row, col)
    end

    #methods to create board from seed string
    def create_board(rows)
      @board_alive = rows.flatten.find_all { |cell| cell.is_alive }
    end

    def rows_from(board_config)
      board_config.split("\n")
    end

    def columns_for(row_config, row)
      row_config.chars.enum_for(:each_with_index).collect { |cell_state, col|
        Cell.new(row,col,state_for(cell_state)) }
    end

    def state_for(cell_representation)
      return DEAD_CELL if DEAD_CELL.to_s == cell_representation.upcase
      ALIVE_CELL
    end

  end

end
