require 'rails_helper'

RSpec.describe ApiToken, type: :model do
  describe "#generate_access_id_and_secrect_key" do
    it "call generate method before create" do
      token = described_class.create name: "test",hostname: "foo.dev"
      expect(token.access_id).not_to eq(nil)
      expect(token.secret_key).not_to eq(nil)
    end
  end
end
