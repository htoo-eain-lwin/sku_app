Rails.application.routes.draw do
  scope "v1", defaults: {format: :json} do
    constraints subdomain: 'api' do
      devise_for :user
      resources :users, only: [:index, :show], controller: "api/v1/users"
    end
  end
end
