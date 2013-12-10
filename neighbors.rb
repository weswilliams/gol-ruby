module GameOfLife

  class Neighbors

    def initialize(cells = [])
      @cells = cells
      @rules = [
          DeadRule.new { |alive_neighbors| alive_neighbors < 2 },
          AliveRule.new { |alive_neighbors, current_state| ( current_state == GameOfLife::ALIVE_CELL && alive_neighbors == 2 ) },
          AliveRule.new { |alive_neighbors,| ( alive_neighbors == 3 ) },
          DeadRule.new { |alive_neighbors| alive_neighbors > 3 }
      ]
    end

    def determine_next_state(current_state)
      current_state.next_state @rules, number_alive
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

  end
end
