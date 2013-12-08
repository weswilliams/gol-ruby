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
      @cells.count{ |cell| cell.is_alive } < 2
    end

    def two_alive
      @cells.count{ |cell| cell.is_alive } == 2
    end

  end
end
