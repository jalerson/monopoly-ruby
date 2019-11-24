RSpec.describe Monopoly::Dice do
  subject { Monopoly::Dice }

  describe 'initialization' do
    context '4-sides' do
      it 'returns a 4-sides dice' do
        dice = subject.new(4)

        expect(dice.sides).to eq(4)
      end
    end

    context '1-side dice' do
      it 'raises ArgumentError' do
        expect { subject.new(1) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#roll' do
    context '2-sides dice' do
      it 'returns 1 or 2' do
        dice = subject.new(2)

        dice.roll

        expect(dice.current_number).to be_between(1, 2).inclusive
      end
    end

    context '4-sides dice' do
      it 'returns number between 1 and 4' do
        dice = subject.new(4)

        dice.roll

        expect(dice.current_number).to be_between(1, 4).inclusive
      end
    end
  end
end
