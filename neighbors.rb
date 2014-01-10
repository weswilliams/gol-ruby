require 'delegate'

module GameOfLife

  class Neighbors < SimpleDelegator

    def initialize(cells = [], row = 0, col = 0)
      @cells = find_neighbors_for(cells, row, col)
      super @cells
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

    private

    def find_neighbors_for(cells, row, col)
      remove_me_from_neighbors(find_all_cells_neighboring(cells, col, row), row, col)
    end

    def find_all_cells_neighboring(cells, col, row)
      neighbor_indexes(row).inject([]) { |neighbors, neighbor_row|
        neighbors + neighbor_indexes(col).collect { |neighbor_col|
          find_cell_at(cells, neighbor_row, neighbor_col) } }
    end

    def neighbor_indexes(cell_index)
      ((cell_index-1)..(cell_index+1))
    end

    def remove_me_from_neighbors(neighbors, my_row, my_col)
      neighbors.reject {|cell| cell.row == my_row && cell.col == my_col}
    end

    def find_cell_at(cells, row, col)
      cells.find(lambda { Cell.new(row, col, DEAD_CELL) }) { |cell| cell.row == row && cell.col == col }
    end

  end
end
