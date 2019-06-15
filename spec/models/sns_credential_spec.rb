require 'rails_helper'

describe SnsCredential do
  describe '#create' do
    # nickname,email,passwordがあればOK
    it "is valid with a provider,email,uid" do
      sns_credential = build(:sns_credential)
      expect(sns_credential).to be_valid
    end
    
    # # emailなしではだめ
    it "is invalid without a email" do
      sns_credential = build(:sns_credential, email: " ")
      sns_credential.valid?
      expect(sns_credential.errors[:email]).to include("can't be blank")
    end

    # # uidなしではだめ
    it "is invalid without a uid" do
      sns_credential = build(:sns_credential, uid: " ")
      sns_credential.valid?
      expect(sns_credential.errors[:uid]).to include("can't be blank")
    end

    # # providerなしではだめ
    it "is invalid without a provider" do
      sns_credential = build(:sns_credential, provider: " ")
      sns_credential.valid?
      expect(sns_credential.errors[:provider]).to include("can't be blank")
    end

  end
end
