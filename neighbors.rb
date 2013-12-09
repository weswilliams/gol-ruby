module GameOfLife

  class LessThanTwoAliveRule
    def apply(number_alive)
      number_alive < 2
    end

    def rule_cell_state
      GameOfLife::DEAD_CELL
    end
  end

  class TwoOrThreeAliveRule
    def apply(number_alive)
      number_alive == 2 || number_alive == 3
    end

    def rule_cell_state
      GameOfLife::ALIVE_CELL
    end
  end

  class Neighbors

    def initialize(cells = [])
      @cells = cells
      @rules = [LessThanTwoAliveRule.new, TwoOrThreeAliveRule.new]
    end

    def determine_next_state
      @rules.find { |rule| rule.apply(number_alive) }.rule_cell_state
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
