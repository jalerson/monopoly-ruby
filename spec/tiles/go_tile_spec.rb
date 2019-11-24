RSpec.describe Monopoly::Tiles::GoTile do
  subject { Monopoly::Tiles::GoTile }

  describe 'constants' do
    describe 'REWARD_ON_LANDING' do
      it 'returns 400' do
        expect(subject::REWARD_ON_LANDING).to eq(400)
      end
    end
  end
end
