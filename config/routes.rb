Rails.application.routes.draw do
  scope "v1", defaults: {format: :json} do
    constraints subdomain: 'api' do

      resources :users, only: [:index, :show], controller: "api/v1/users"
      resources :products, controller: "api/v1/products"
      devise_scope :user do
        post "/login", to: "api/v1/sessions#create"
        delete "/logout", to: "api/v1/sessions#destroy"
      end
    end
  end
end
