module GameOfLife

  class Rule
    def initialize(cell_state, rule)
      @cell_state = cell_state
      @rule = rule
    end
    def apply(number_alive)
      @rule.call number_alive
    end
    def rule_cell_state
      @cell_state
    end
  end

  class AliveRule < SimpleDelegator
    def initialize(&rule)
      __setobj__ Rule.new(GameOfLife::ALIVE_CELL, rule)
    end
  end

  class DeadRule < SimpleDelegator
    def initialize(&rule)
      __setobj__ Rule.new(GameOfLife::DEAD_CELL, rule)
    end
  end

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
      @rules.find { |rule| rule.apply(number_alive) }.rule_cell_state
    end

    def number_alive
      @cells.count { |cell| cell.is_alive }
    end

  end
end
