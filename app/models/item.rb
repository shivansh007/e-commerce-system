class Item < ActiveRecord::Base
  belongs_to :category
  has_many :orders
  validates :name, presence: true
  validates :description, presence: true
  validates :brand, presence: true
  validates :price, presence: true, numericality: { only_float: true }
  validates :stock, presence: true, numericality: true
  validates :category_id, presence: true, numericality: true
end
