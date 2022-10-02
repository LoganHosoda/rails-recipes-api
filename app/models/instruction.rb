class Instruction < ApplicationRecord
  # model association
  belongs_to :recipe
  accepts_nested_attributes_for :recipe, update_only: true

  # validations
  validates_presence_of :step
end
