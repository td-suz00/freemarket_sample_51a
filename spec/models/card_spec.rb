require 'rails_helper'

describe Card do
  describe '#pay' do
    context 'can save' do
      it 'is valid with card_id and customer_id and user_id' do
        expect(build(:card)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without card_id' do
        card = build(:card, card_id: nil)
        card.valid?
        expect(card.errors[:card_id]).to include("can't be blank")
      end

      it 'is invalid without customer_id' do
        card = build(:card, customer_id: nil)
        card.valid?
        expect(card.errors[:customer_id]).to include("can't be blank")
      end

      it 'is invalid without user_id' do
        card = build(:card, user_id: nil)
        card.valid?
        expect(card.errors[:user_id]).to include("can't be blank")
      end

      it 'is invalid without user_id' do
        card = build(:card, user_id: nil)
        card.valid?
        expect(card.errors[:user_id]).to include("can't be blank")
      end

      it 'is invalid with same customer_id' do
        card = build(:card, customer_id: 'cus_3aa7599216f876b0c5c397867599')
        card.valid?
        expect(card.errors[:customer_id]).to include("has already been taken")
      end

      it 'is invalid with same card_id' do
        card = build(:card, card_id: 'car_339fe1eb69d0e1f75417fd2c0162')
        card.valid?
        expect(card.errors[:card_id]).to include("has already been taken")
      end

      it 'is invalid with same user_id' do
        card = build(:card, user_id: 3)
        card.valid?
        expect(card.errors[:user_id]).to include("has already been taken")
      end
    end
  end
end