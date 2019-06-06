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

    it "is invalid without name" do
      item = build(:item,name:"")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "is invalid without category_id" do
      item = build(:item,category_id:nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
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
      binding.pry
      expect(item).to be_valid
    end


    # it "is invalid without a password" do
    #   user = build(:user, password: " ")
    #   user.valid?
    #   expect(user.errors[:password]).to include("can't be blank")
    # end
    
    # # emailなしではだめ
    # it "is invalid without a email" do
    #   user = build(:user, email: " ")
    #   user.valid?
    #   expect(user.errors[:email]).to include("can't be blank")
    # end

    # # nicknameなしではだめ
    # it "is invalid without a nickname" do
    #   user = build(:user, nickname: " ")
    #   user.valid?
    #   expect(user.errors[:nickname]).to include("can't be blank")
    # end

    # # nicknameに"メルカリ"が入るとだめ
    # it "is invalid with nickname include 'メルカリ' " do
    #   user = build(:user, nickname: "メルカリ")
    #   user.valid?
    #   expect(user.errors[:nickname]).to include("is reserved")
    # end



    # # passwordがあってもpassword_confirmationがないとだめ
    # it "is invalid without a password_confirmation if password exist" do
    #   user = build(:user, password_confirmation: " ")
    #   user.valid?
    #   expect(user.errors[:password_confirmation]).to include("can't be blank")
    # end

    # # emailかぶっちゃだめ
    # it "is invalid with duplicate email" do
    #   user = create(:user)
    #   another_user = build(:user)
    #   another_user.valid?
    #   expect(another_user.errors[:email]).to include("has already been taken")
    # end
    # text                  {"item1-text"}
    # price                 {1000}
    # brand_id                 {1}
    # category_id              {1}
    # size_id                  {1}
    # condition             {"目立った傷や汚れなし"}
    # delivery_fee_payer    {"送料込み（出品者負担）"}
    # delivery_type         {"らくらくメルカリ便"}
    # delibery_from_area    {"北海道"}
    # delivery_days         {"1~2日で発送"}
    # パスワード６文字以上ならOK
    # it "is valid with password over 6 letters" do
    #   user = build(:user, password: "hoge00", password_confirmation: "hoge00")
    #   expect(user).to be_valid
    # end

    # # パスワード５文字以下だとだめ
    # it "is invalid with password less than 5 letters" do
    #   user = build(:user, password: "hoge0", password_confirmation: "hoge0")
    #   user.valid?
    #   expect(user.errors[:password][0]).to include("is too short")
    # end

    # # 数字だけのパスワードはだめ
    # it "is invalid with password only integer" do
    #   user = build(:user, password: "00000000", password_confirmation: "00000000")
    #   user.valid?
    #   expect(user.errors[:password]).to include("is invalid")
    # end
    
  end
end
