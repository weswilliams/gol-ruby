module GameOfLife

  class Neighbors

    def initialize(cells = [])
      @cells = cells
      @rules = [
          Rule.new(GameOfLife::ALIVE_CELL) { |neighbors, current_state| ( current_state == GameOfLife::ALIVE_CELL && neighbors.number_alive == 2 ) },
          Rule.new(GameOfLife::ALIVE_CELL) { |neighbors,| ( neighbors.number_alive == 3 ) },
          Rule.new(GameOfLife::DEAD_CELL) { |neighbors| neighbors.number_alive < 2 },
          Rule.new(GameOfLife::DEAD_CELL) { |neighbors| neighbors.number_alive > 3 }
      ]
    end

    def determine_next_state(current_state)
      current_state.next_state self
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

  end
end
