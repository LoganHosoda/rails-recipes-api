require 'rails_helper'
require './spec/requests/recipes_spec'

RSpec.describe "Recipes API", type: :request do
  # initialize test data
  let!(:recipes) { create_list(:recipe, 10) }
  let(:recipe_id) { recipes.first.id }

  # Test suite for GET /recipes
  describe 'GET /recipes' do
    # make HTTP get request before each example
    before { get '/recipes' }

    it 'returns recipes' do
      # Note 'json' is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /recipes/:id
  describe 'GET /recipes/:id' do
    before { get "/recipes/#{recipe_id}" }

    context 'when the record exists' do
      it 'returns the recipe' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(recipe_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:recipe_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  # Test suite for POST /recipes
  describe 'POST /recipes' do
    # valid payload
    let(:valid_attributes) { { name: 'Scrambled Eggs' } }

    context 'when the request is valid' do
      before { post '/recipes', params: valid_attributes }

      it 'creates a recipe' do
        expect(json['name']).to eq('Scrambled Eggs')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/recipes', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /recipes/:id
  describe 'PUT /recipes/:id' do
    let(:valid_attributes) { { name: 'Toast' } }

    context 'when the record exists' do
      before { put "/recipes/#{recipe_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /recipes/:id
  describe 'DELETE /recipes/:id' do
    before { delete "/recipes/#{recipe_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
