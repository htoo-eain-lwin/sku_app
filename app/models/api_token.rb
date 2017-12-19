class ApiToken < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  before_create :generate_access_id_and_secrect_key

  private
    def generate_access_id_and_secrect_key
      begin
        self.access_id = Array.new(4){rand(1..9)}.join.to_i
        self.secret_key = ApiAuth.generate_secret_key
      end while self.class.exists?(access_id: access_id, secret_key: secret_key)
    end

end
