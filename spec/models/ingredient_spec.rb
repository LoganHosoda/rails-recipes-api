require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  # Association test
  # ensure an instruction record belongs to a single recipe record
  it { should belong_to(:recipe) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
