module GameOfLife

  class Rule
    def initialize(cell_state, &rule)
      @cell_state = cell_state
      @rule = rule
    end
    def apply(number_alive, current_state)
      @rule.call number_alive, current_state
    end
    def rule_cell_state
      @cell_state
    end
  end

  def rules
    if @rules == nil
      @rules = [
          Rule.new(GameOfLife::ALIVE_CELL) { |neighbors, current_state|
            ( current_state == GameOfLife::ALIVE_CELL && neighbors.number_alive == 2 ) },
          Rule.new(GameOfLife::ALIVE_CELL) { |neighbors| ( neighbors.number_alive == 3 ) },
          Rule.new(GameOfLife::DEAD_CELL) { |neighbors| neighbors.number_alive < 2 },
          Rule.new(GameOfLife::DEAD_CELL) { |neighbors| neighbors.number_alive > 3 }
      ]
    end
    @rules
  end

end
