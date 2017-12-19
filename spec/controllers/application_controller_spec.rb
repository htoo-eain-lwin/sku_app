require 'rails_helper'

describe ApplicationController, type: :controller do
  controller do
    def index
      raise Pundit::NotAuthorizedError
    end
  end

  describe "it rescue pundit not authorized error" do
    it "return 401 unauthorized message" do
      get :index
      expect(response.status).to eq(401)
    end
  end

end