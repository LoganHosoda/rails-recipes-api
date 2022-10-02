FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    recipe_id { nil }
  end
end