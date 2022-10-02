require 'json'

recipes = JSON.parse(File.read('db/data.json'))

counter = 0
ingredients_counter = 0
instructions_counter = 0

while counter < recipes['recipes'].length
  puts "Recipe #{counter} = #{recipes['recipes'][counter]['name']}"
  while ingredients_counter < recipes['recipes'][counter]['ingredients'].length
    p "Ingredients #{counter} = #{recipes['recipes'][counter]['ingredients'][ingredients_counter]}"
    ingredients_counter += 1
  end
  while instructions_counter < recipes['recipes'][counter]['instructions'].length
    p "Instructions #{counter} = #{recipes['recipes'][counter]['instructions'][instructions_counter]}"
    instructions_counter += 1
  end
  counter += 1
  ingredients_counter = 0
  instructions_counter = 0
end
