module GameOfLife

  class Neighbors

    def initialize(cells = [])
      @cells = cells
      @rules = [
          DeadRule.new { number_alive < 2 },
          AliveRule.new {number_alive == 2 || number_alive == 3},
          DeadRule.new { number_alive > 3 }
      ]
    end

    def determine_next_state(current_state)
      @rules.find { |rule| current_state.apply(rule, number_alive) }.rule_cell_state
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

  end
end
