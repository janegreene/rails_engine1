FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { "4147909988776655" }
    credit_card_expiration_date { "2020-07-11" }
    result { "denied" }
  end
end
