require 'rails_helper'

describe User do
  describe '#create' do

    # nickname,email,passwordがあればOK
    it "is valid with a nickname,email,password" do
      user = build(:user)
      expect(user).to be_valid
    end
    
    # emailなしではだめ
    it "is invalid without a email" do
      user = build(:user, email: " ")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # nicknameなしではだめ
    it "is invalid without a nickname" do
      user = build(:user, nickname: " ")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # nicknameに"メルカリ"が入るとだめ
    it "is invalid with nickname include 'メルカリ' " do
      user = build(:user, nickname: "メルカリ")
      user.valid?
      expect(user.errors[:nickname]).to include("is reserved")
    end

    # passwordなしではだめ
    it "is invalid without a password" do
      user = build(:user, password: " ")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # passwordがあってもpassword_confirmationがないとだめ
    it "is invalid without a password_confirmation if password exist" do
      user = build(:user, password_confirmation: " ")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    # emailかぶっちゃだめ
    it "is invalid with duplicate email" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # パスワード６文字以上ならOK
    it "is valid with password over 6 letters" do
      user = build(:user, password: "hoge00", password_confirmation: "hoge00")
      expect(user).to be_valid
    end

    # パスワード５文字以下だとだめ
    it "is invalid with password less than 5 letters" do
      user = build(:user, password: "hoge0", password_confirmation: "hoge0")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

    # 数字だけのパスワードはだめ
    it "is invalid with password only integer" do
      user = build(:user, password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user.errors[:password]).to include("is invalid")
    end
    
  end
end
