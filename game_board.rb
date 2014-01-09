require 'delegate'
require_relative 'cell'
require_relative 'neighbors'
require_relative 'rule'

module GameOfLife

  DEAD_BOARD_CELL = Cell.new(0,0,DEAD_CELL)

  class GameBoard

    attr_reader :board_alive

    def initialize(board_config = '')
      create_board(rows_from(board_config).enum_for(:each_with_index).collect {|row_config, row| columns_for row_config, row })
    end

    def to_s_size(start_index = 0, max_dim = 100)
      index_range(max_dim, start_index).inject('') { |board, row| row_string(board, max_dim, start_index, row) + "\n" }
    end

    def index_range(max_dim, start_index)
      (start_index..(start_index+max_dim))
    end

    def row_string(board_string, max_dim, start_index, row)
      index_range(max_dim, start_index).inject(board_string) { |row_cells, col| row_cells + find_cell_at(row, col).to_s }
    end

    def find_cell_at(row, col)
      @board_alive.find(lambda { Cell.new(row, col, DEAD_CELL) }) { |cell| cell.row == row && cell.col == col }
    end

    def to_s
      to_s_size
    end

    def next_life
      live_cell_and_neighbors = @board_alive.inject([]) { |cells, cell|
        cells + find_all_neighbors_for(cell.row, cell.col)
      }
      uniq_cells = live_cell_and_neighbors.uniq {|cell| cell.hash }
      next_life_cells = uniq_cells.collect { |cell|
        cell.next_life(find_live_neighbors_for(cell.row, cell.col))
      }
      create_board(next_life_cells)
      self
    end

    # next life methods
    def active_dim(dim)
      return (0..0) if @board_alive.none?
      ((find_min_max_dim(:min, dim, :-))..(find_min_max_dim(:max, dim, :+)))
    end

    def find_min_max_dim(min_max, dim, plus_minus)
      @board_alive.send(min_max, &compare_dim(dim)).send(dim).send(plus_minus,1)
    end

    def compare_dim(dim)
      lambda {|cell1, cell2| cell1.send(dim) <=> cell2.send(dim) }
    end

    def find_live_neighbors_for(row, col)
      Neighbors.new(@board_alive.select do |cell|
        cell.is_neighboring(:row, row) && cell.is_neighboring(:col, col) && cell.is_not_me(row, col)
      end)
    end

    def find_all_neighbors_for(row, col)
      ((row-1)..(row+1)).inject([]) { |neighbors, row|
        neighbors + ((col-1)..(col+1)).collect {|col| find_cell_at(row, col) } }
    end

    #methods to create board from seed string
    def create_board(rows)
      @board_alive = rows.flatten.find_all { |cell| cell.is_alive }
    end

    def rows_from(board_config)
      board_config.split("\n")
    end

    def columns_for(row_config, row)
      row_config.chars.enum_for(:each_with_index).collect { |cell_state, col| Cell.new(row,col,state_for(cell_state)) }
    end

    def state_for(cell_representation)
      return DEAD_CELL if DEAD_CELL.to_s == cell_representation.upcase
      ALIVE_CELL
    end

  end

end
