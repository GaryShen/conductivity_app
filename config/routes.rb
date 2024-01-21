Rails.application.routes.draw do
  root "grid_evaluations#index"

  resources :grid_evaluations, only: %i[index new create show] do
    get :generate_random_grid, on: :collection
  end
end
