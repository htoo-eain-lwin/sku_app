class Warehouse < ApplicationRecord
  validates :name, presence: true
  validates :distribution_center_id, presence: true

  belongs_to :distribution_center
  has_many :inventories
end
