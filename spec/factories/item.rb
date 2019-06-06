FactoryBot.define do

  factory :item do
    id                    {1}
    name                  {"item1"}
    text                  {"item1-text"}
    price                 {1000}
    brand_id                 {1}
    category_id              {1}
    size_id                  {1}
    condition             {"目立った傷や汚れなし"}
    delivery_fee_payer    {"送料込み（出品者負担）"}
    delivery_type         {"らくらくメルカリ便"}
    delibery_from_area    {"北海道"}
    delivery_days         {"1~2日で発送"}
  end

end
