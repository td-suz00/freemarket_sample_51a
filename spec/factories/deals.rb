FactoryBot.define do

  factory :deal do
    charge_id        {}
    deal_at          {}
    status_id        {1}
    buyer_id         {}
    seller_id        {3}
    item_id          {5}
  end

end