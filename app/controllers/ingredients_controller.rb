class IngredientsController < ApplicationController
  require 'json'

  before_action :set_recipe
  before_action :set_recipe_ingredient, only: %i[show update destroy]

  # GET /recipes/:recipe_id/ingredients
  def index
    @array = []
    @recipe.ingredients.each do |data|
      @array.push(data['name'])
    end
    @ingredients = JSON.parse(@array[0])
    @details = {
      "details":
      { "ingredients": @ingredients, "numSteps": @ingredients.length }
    }
    json_response(@details)
  end

  # GET /recipes/:recipe_id/ingredients:id
  def show
    json_response(@ingredient)
  end

  # POST /recipes/:recipe_id/ingredients
  def create
    @recipe.ingredients.create!(ingredient_params)
    json_response(@recipe, :created)
  end

  # PUT /recipes/:recipe_id/ingredients:id
  def update
    @ingredient.update(ingredient_params)
    head :no_content
  end

  # DELETE /recipes/:recipe_id/ingredients/:id
  def destroy
    @ingredient.destroy
    head :no_content
  end

  private

  def ingredient_params
    params.permit(:ingredient, :name, name: :recipe_id)
  end

  def set_recipe
    @recipe = Recipe.find_by(name: params[:recipe_id])
  end

  def set_recipe_ingredient
    @ingredient = @recipe.ingredients.find_by!(id: params[:id]) if @recipe
  end
end
