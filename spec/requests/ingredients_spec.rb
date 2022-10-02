require 'rails_helper'

RSpec.describe 'Ingredients API' do
  # Initialize the test data
  let!(:recipe) { create(:recipe) }
  let!(:ingredients) { create_list(:ingredient, 20, recipe_id: recipe.id) }
  let!(:recipe_id) { recipe.id }
  let(:id) { ingredients.first.id }

  # Test suite for GET /recipes/:recipe_id/ingredients
  describe 'GET /recipes/:recipe_id/ingredients' do
    before { get "/recipes/#{recipe_id}/ingredients" }

    context 'when recipe exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all recipe items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when recipe does not exist' do
      let(:recipe_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  # Test suite for GET /recipes/:recipe_id/ingredients/:id
  describe 'GET /recipes/:recipe_id/ingredients/:id' do
    before { get "/recipes/#{recipe_id}/ingredients/#{id}" }

    context 'when recipe ingredient exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the ingredient' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when recipe ingredient does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  # Test suite for PUT /recipes/:recipe_id/ingredients
  describe 'POST /recipes/:recipe_id/ingredients' do
    let(:valid_attributes) { { name: 'Salt' } }

    context 'when request attributes are valid' do
      before { post "/recipes/#{recipe_id}/ingredients", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/recipes/#{recipe_id}/ingredients", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /recipes/:recipe_id/ingredients:id
  describe 'PUT /recipes/:recipe_id/ingredients/:id' do
    let(:valid_attributes) { { name: 'Butter' } }

    before { put "/recipes/#{recipe_id}/ingredients/#{id}", params: valid_attributes }

    context 'when ingredient exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the ingredient' do
        updated_ingredient = Ingredient.find(id)
        expect(updated_ingredient.name).to match(/Butter/)
      end
    end

    context 'when the ingredient does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ingredient/)
      end
    end
  end

  # Test suite for DELETE /recipes/:recipe_id/ingredients/:id
  describe 'DELETE /recipes/:recipe_id/ingredients/:id' do
    before { delete "/recipes/#{recipe_id}/ingredients/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
