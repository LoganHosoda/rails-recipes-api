class InstructionsController < ApplicationController
  require 'json'

  before_action :set_recipe
  before_action :set_recipe_instruction, only: %i[show update destroy]

  # GET /recipes/:recipe_id/instructions
  def index
    json_response(@recipe.instructions)
  end

  # GET /recipes/:recipe_id/instructions/:id
  def show
    json_response(@instruction)
  end

  # POST /recipes/:recipe_id/instructions
  def create
    @recipe.instructions.create!(instruction_params)
    json_response(@recipe, :created)
  end

  # PUT /recipes/:recipe_id/instructions/:id
  def update
    @instruction.update(instruction_params)
    head :no_content
  end

  # DELETE /recipes/:recipe_id/instructions/:id
  def destroy
    @instruction.destroy
    head :no_content
  end

  private

  def instruction_params
    params.permit(:step)
  end

  def set_recipe
    @recipe = Recipe.find_by(name: params[:recipe_id])
  end

  def set_recipe_instruction
    @instruction = @recipe.instructions.find_by!(id: params[:id]) if @recipe
  end
end
