FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Movies::HitchhikersGuideToTheGalaxy.starship }
    description { Faker::Movies::HitchhikersGuideToTheGalaxy.quote }
    unit_price { 1.5 }
  end
end
