module Monopoly::Decorators
  module PropertyTileDecorator
    def name
      has_owner? ? "P#{owner.number} " : 'P  '
    end
  end
end
