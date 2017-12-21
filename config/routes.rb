Rails.application.routes.draw do
  scope "v1", defaults: {format: :json} do
    constraints subdomain: 'api' do
      devise_for :users, skip: :all
      resources :users, only: [:index, :show], controller: "api/v1/users"
      resources :products, controller: "api/v1/products"
      resources :warehouses, controller: "api/v1/warehouses"
      devise_scope :user do
        post "/login", to: "api/v1/sessions#create"
        delete "/logout", to: "api/v1/sessions#destroy"
      end
    end
  end
end
