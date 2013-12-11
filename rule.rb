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

end
