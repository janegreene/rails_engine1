Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        resources :items, except: [:new, :edit] do
          resources :merchant, only: [:index], controller: 'item_merchants'
        end
        resources :merchants, only: [:show, :index, :create, :destroy, :update] do
          resources :items, only: [:index], controller: 'merchant_items'
        end
    end
  end
end
