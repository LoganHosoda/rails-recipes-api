Rails.application.routes.draw do
  resources :recipes do
    resources :ingredients, :instructions, param: :name
  end

  get 'recipes/details/:recipe_id', to: 'ingredients#index'
end
