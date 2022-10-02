FactoryBot.define do
  factory :instruction do
    step { Faker::Food.description }
    recipe_id { nil }
  end
end