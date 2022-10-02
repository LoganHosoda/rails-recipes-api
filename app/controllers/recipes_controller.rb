class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show update destroy]

  # GET /recipes
  def index
    @recipes = Recipe.all
    @recipe_array = Array.new
    @recipes.each do |recipe|
      @recipe_array.push(recipe['name'])
    end
    @recipes = { "recipeNames": @recipe_array }
    json_response(@recipes)
  end

  # POST /recipes
  def create
    @recipe = Recipe.create!(recipe_params)
    json_response(@recipe, :created)
  end

  # GET /recipes/:id
  def show
    json_response(@recipe)
  end

  # PUT /recipes/:id
  def update
    @recipe.update(recipe_params)
    head :no_content
  end

  # DELETE /recipes/:id
  def destroy
    @recipe.destroy
    head :no_content
  end

  private

  def recipe_params
    # whitelist params
    params.permit(:name)
  end

  def set_recipe
    @recipe = Recipe.find_by(name: params[:id])
  end

  def set_recipe_ingredient
    @ingredient = @recipe.ingredients.find_by!(id: params[:id]) if @recipe
  end

  def set_recipe_instruction
    @instruction = @recipe.instructions.find_by!(id: params[:id]) if @recipe
  end
end
