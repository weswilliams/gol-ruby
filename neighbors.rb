module GameOfLife

  class Neighbors

    def initialize(cells = [])
      @cells = cells
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

    def size
      @cells.size
    end

  end
end
