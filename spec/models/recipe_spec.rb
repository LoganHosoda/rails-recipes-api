require 'rails_helper'

RSpec.describe Recipe, type: :model do
  # Association test
  # ensure Recipe model has a relationship with
  # Ingredient and Instruction models
  it { should have_many(:ingredients).dependent(:destroy) }
  it { should have_many(:instructions).dependent(:destroy) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
