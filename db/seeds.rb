# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

recipes = JSON.parse(File.read('db/data.json'))

recipes['recipes'].each do |recipe_data|
  Recipe.create!(name: recipe_data['name'])
  Ingredient.create!(
    name: recipe_data['ingredients'], recipe_id: Recipe.last.id
  )
  Instruction.create!(
    step: recipe_data['instructions'], recipe_id: Recipe.last.id
  )
end
