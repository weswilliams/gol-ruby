module GameOfLife

  class Neighbors

    def initialize(cells = [])
      @cells = cells
      @rules = [
          DeadRule.new { |neighbors| neighbors.number_alive < 2 },
          AliveRule.new { |neighbors, current_state| ( current_state == GameOfLife::ALIVE_CELL && neighbors.number_alive == 2 ) },
          AliveRule.new { |neighbors,| ( neighbors.number_alive == 3 ) },
          DeadRule.new { |neighbors| neighbors.number_alive > 3 }
      ]
    end

    def determine_next_state(current_state)
      current_state.next_state @rules, self
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

  end
end
