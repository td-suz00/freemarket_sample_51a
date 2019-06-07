require 'rails_helper'

describe Deal do
  describe '#pay' do
    context 'can save' do
      it 'is valid with charge_id, buyer_id, deal_at, status_id' do
        expect(build(:deal)).to be_valid
      end

      it 'is valid without updating buyer_id' do
        expect(build(:deal, buyer_id: nil)).to be_valid
      end

      it 'is valid without updating deal_at' do
        expect(build(:deal, deal_at: nil)).to be_valid
      end

      it 'is valid without updating status_id' do
        expect(build(:deal, status_id: 1)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid with same charge_id' do
        deal = build(:deal, charge_id: 'ch_eaaa234a10fd2ed9259675a740cc4')
        deal.valid?
        expect(deal.errors[:charge_id]).to include("has already been taken")
      end
    end
  end
end