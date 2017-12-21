class User < ApplicationRecord
  acts_as_token_authenticatable
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :assign_default_role
  scope :admins, -> { with_role(:admin)}
  scope :customers,-> { with_role(:customers)}
  scope :sales,-> { with_role(:sales)}

  def assign_default_role
    add_role(:user)
  end
end

class Admin < User
  after_create :assign_default_role
  default_scope { with_role(:admin) }

  def assing_default_role
    add_role(:admin)
  end

end

class Customer < User
  after_create :assign_default_role
  default_scope { with_role(:customer) }

  def assing_default_role
    add_role(:customer)
  end
end

class SalesPerson < User
  after_create :assign_default_role
  default_scope { with_role(:sales) }

  def assing_default_role
    add_role(:sales)
  end
end