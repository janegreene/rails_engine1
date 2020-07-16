Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        namespace :merchants do
          get :find_all, to: "search#index"
          get :find, to: "search#show"
          get :most_revenue, to: "most_revenue#index"
          get :most_items, to: "most_items#index"
        end
        namespace :items do
          get :find_all, to: "search#index"
          get :find, to: "search#show"
        end
        resources :items, except: [:new, :edit] do
          resources :merchant, only: [:index], controller: 'item_merchants'
        end
        resources :merchants, only: [:show, :index, :create, :destroy, :update] do
          resources :items, only: [:index], controller: 'merchant_items'
        end
        get '/revenue', to: "revenue#index"
    end
  end
end
