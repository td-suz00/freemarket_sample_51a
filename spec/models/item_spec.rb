require 'rails_helper'

describe Item do

  describe '#create' do
    # アソシエーションの作成
    before do
      brand = create(:brand)
      category= create(:category)
      size = create(:size)
    end

    it "is valid with all collect" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "is invalid without name" do
      item = build(:item,name:"")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is invalid without text" do
      item = build(:item,text:"")
      item.valid?
      expect(item.errors[:text]).to include("can't be blank")
    end

    it "is invalid without price" do
      item = build(:item,price:nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "is invalid without category_id" do
      item = build(:item,category_id:nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    it "is invalid without condition" do
      item = build(:item,condition:"")
      item.valid?
      expect(item.errors[:condition]).to include("can't be blank")
    end

    it "is invalid without delivery_fee_payer" do
      item = build(:item,delivery_fee_payer:"")
      item.valid?
      expect(item.errors[:delivery_fee_payer]).to include("can't be blank")
    end

    it "is invalid without delivery_type" do
      item = build(:item,delivery_type:"")
      item.valid?
      expect(item.errors[:delivery_type]).to include("can't be blank")
    end

    it "is invalid without delibery_from_area" do
      item = build(:item,delibery_from_area:"")
      item.valid?
      expect(item.errors[:delibery_from_area]).to include("can't be blank")
    end

    it "is invalid without delivery_days" do
      item = build(:item,delivery_days:"")
      item.valid?
      expect(item.errors[:delivery_days]).to include("can't be blank")
    end

    it "is valid with lowest price" do
      item = build(:item,price:300)
      expect(item).to be_valid
    end

     it "is valid with highest price" do
      item = build(:item,price:9_999_999)
      expect(item).to be_valid
    end

    it "is invalid with too low price" do
      item = build(:item,price:299)
      item.valid?
      expect(item.errors[:price]).to include("must be greater than or equal to 300")
    end

    it "is invalid with too high price" do
      item = build(:item,price:10_000_000)
      item.valid?
      expect(item.errors[:price]).to include("must be less than or equal to 9999999")
    end

    it "is valid without size_id" do
      item = build(:item,size_id:"")
      expect(item).to be_valid
    end
  end

  describe '#edit' do
    # アソシエーションの作成
    before do
      brand = create(:brand)
      category= create(:category)
      size = create(:size)
    end

    it "is valid with all collect" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "is invalid without name" do
      item = build(:item,name:"")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is invalid without text" do
      item = build(:item,text:"")
      item.valid?
      expect(item.errors[:text]).to include("can't be blank")
    end

    it "is invalid without price" do
      item = build(:item,price:nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "is invalid without category_id" do
      item = build(:item,category_id:nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    it "is invalid without condition" do
      item = build(:item,condition:"")
      item.valid?
      expect(item.errors[:condition]).to include("can't be blank")
    end

    it "is invalid without delivery_fee_payer" do
      item = build(:item,delivery_fee_payer:"")
      item.valid?
      expect(item.errors[:delivery_fee_payer]).to include("can't be blank")
    end

    it "is invalid without delivery_type" do
      item = build(:item,delivery_type:"")
      item.valid?
      expect(item.errors[:delivery_type]).to include("can't be blank")
    end

    it "is invalid without delibery_from_area" do
      item = build(:item,delibery_from_area:"")
      item.valid?
      expect(item.errors[:delibery_from_area]).to include("can't be blank")
    end

    it "is invalid without delivery_days" do
      item = build(:item,delivery_days:"")
      item.valid?
      expect(item.errors[:delivery_days]).to include("can't be blank")
    end

    it "is valid with lowest price" do
      item = build(:item,price:300)
      expect(item).to be_valid
    end

     it "is valid with highest price" do
      item = build(:item,price:9_999_999)
      expect(item).to be_valid
    end

    it "is invalid with too low price" do
      item = build(:item,price:299)
      item.valid?
      expect(item.errors[:price]).to include("must be greater than or equal to 300")
    end

    it "is invalid with too high price" do
      item = build(:item,price:10_000_000)
      item.valid?
      expect(item.errors[:price]).to include("must be less than or equal to 9999999")
    end

    it "is valid without size_id" do
      item = build(:item,size_id:"")
      expect(item).to be_valid
    end
  end

end
