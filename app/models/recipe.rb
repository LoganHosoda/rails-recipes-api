class Recipe < ApplicationRecord
  # model association
  has_many :instructions, dependent: :destroy
  has_many :ingredients, dependent: :destroy

  # validations
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:name]

  def to_param
    name
  end
end
