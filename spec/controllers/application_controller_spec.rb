require 'rails_helper'

describe ApplicationController, type: :controller do
  controller do
    def index
      raise Pundit::NotAuthorizedError
    end

    def show
      raise ActiveRecord::RecordNotFound
    end
  end

  before do
    @routes.draw do
      get '/anonymous/index'
      get '/anonymous/show'
    end
  end

  describe "it rescue pundit not authorized error" do
    it "return 401 unauthorized message" do
      get :index
      expect(response.status).to eq(401)
    end
  end

  describe "it rescue active record not found error" do
    it "return 404 unauthorized message" do
      bypass_apiauth
      get :show
      expect(response.status).to eq(404)
    end
  end
end