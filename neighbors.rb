module GameOfLife
  class Neighbors
    def determine_next_state
      GameOfLife::DEAD_CELL if less_than_two_live
    end

    def less_than_two_live
      true
    end

  end
end
