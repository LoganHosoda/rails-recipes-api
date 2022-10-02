require 'rails_helper'

RSpec.describe "Instructions API" do
  # initialize test data
  let!(:recipe) { create(:recipe) }
  let!(:instructions) { create_list(:instruction, 20, recipe_id: recipe_id) }
  let(:recipe_id) { recipe.id }
  let(:id) { instructions.first.id }

  # Test suite for GET /recipes/:recipe_id/instructions/:id
  describe 'GET /recipes/:recipe_id/instructions/:id' do
    before { get "/recipes/#{recipe_id}/instructions/#{id}" }

    context 'when recipe instruction exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the instruction' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when recipe instruction does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Instruction/)
      end
    end
  end

  # Test suite for GET /recipes/:recipe_id/instructions/:id
  describe 'GET /recipes/:recipe_id/instructions/:id' do
    before { get "/recipes/#{recipe_id}/instructions/#{id}" }

    context 'when the recipe instruction exists' do
      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when recipe instruction does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Instruction/)
      end
    end
  end

  # Test suite for POST /recipes/:recipe_id/instructions
  describe 'POST /recipes/:recipe_id/instructions' do
    let(:valid_attributes) { { step: 'Mix well' } }

    context 'when request attributtes are valid' do
      before { post "/recipes/#{recipe_id}/instructions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/recipes/#{recipe_id}/instructions", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Step can't be blank/)
      end
    end
  end

  # Test suite for PUT /recipes/:id
  describe 'PUT /recipes/:id' do
    let(:valid_attributes) { { step: 'mix and steep 3-4 minutes' } }

    before { put "/recipes/#{recipe_id}/instructions/#{id}", params: valid_attributes}

    context 'when instruction exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the instruction' do
        updated_instruction = Instruction.find(id)
        expect(updated_instruction.step).to match(/mix and steep 3-4 minutes/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Instruction/)
      end
    end
  end

  # Test suite for DELETE /recipes/:recipe_id/instructions/#{id}
  describe 'DELETE /recipes/:recipe_id/instructions/:id' do
    before { delete "/recipes/#{recipe_id}/instructions/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
