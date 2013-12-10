module GameOfLife

  class Neighbors

    def initialize(cells = [])
      @cells = cells
      @rules = [
          DeadRule.new { |number_alive| number_alive < 2 },
          AliveRule.new { |number_alive, current_state| ( current_state == GameOfLife::ALIVE_CELL && number_alive == 2 ) },
          AliveRule.new { |number_alive,| ( number_alive == 3 ) },
          DeadRule.new { |number_alive| number_alive > 3 }
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
