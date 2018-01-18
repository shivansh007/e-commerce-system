class Invoice < ActiveRecord::Base
  belongs_to :order
  validates :order_id, presence: true, numericality: true
end
