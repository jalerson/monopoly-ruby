module Monopoly
  class Player
    include Monopoly::Decorators::PlayerDecorator

    attr_reader :number, :properties, :balance
    attr_accessor :position

    DEFAULT_START_BALANCE = 1500.freeze

    def initialize(number, start_balance: DEFAULT_START_BALANCE)
      @number = number
      @position = 0
      @properties = []
      @balance = start_balance
    end

    def add_property(property)
      @properties << property
    end

    def receives(amount)
      @balance += amount
    end

    def pays(amount)
      @balance -= amount
    end

    def has_balance?(amount)
      balance >= amount
    end
  end
end
