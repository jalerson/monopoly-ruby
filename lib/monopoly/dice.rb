module Monopoly
  class Dice
    attr_reader :current_number, :sides

    MIN_SIDES = 2
    DEFAULT_SIDES = 6

    def initialize(sides = DEFAULT_SIDES)
      raise ArgumentError, "sides must be >= #{MIN_SIDES}" if sides < MIN_SIDES

      @sides = sides
    end

    def roll
      @current_number = rand(1..sides)
    end
  end
end
