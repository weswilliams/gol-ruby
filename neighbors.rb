module GameOfLife
  class Neighbors

    def initialize(cells = [])
      @cells = cells
    end

    def determine_next_state
      return GameOfLife::DEAD_CELL if less_than_two_live
      GameOfLife::ALIVE_CELL if two_alive
    end

    def less_than_two_live
      number_alive() < 2
    end

    def two_alive
      number_alive() == 2 || number_alive == 3
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

  end
end
