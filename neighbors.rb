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
      @rules.find(Proc.new {Rule.new current_state, nil}) { |rule| current_state.apply(rule, number_alive) }.rule_cell_state
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

  end
end
