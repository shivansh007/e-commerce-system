class Order < ActiveRecord::Base
  enum payment_status: { 'done' => 1, 'pending' => 0 }
  enum payment_mode: { 'credit_card' => 1, 'debit_card' => 2, 'net_banking' => 3, 'cod' => 4 }
  enum order_status: { 'placed' => 1, 'shipped' => 2, 'dispatched' => 3, 'delivered' => 4 }
  belongs_to :item
  belongs_to :user
  has_one :invoice
  validates :item_id, presence: true, numericality: true
  validates :user_id, presence: true, numericality: true
  validates :payment_mode, inclusion: { in: Order.payment_modes.keys }
  validates :payment_status, inclusion: { in: Order.payment_statuses.keys }
  validates :order_status, inclusion: { in: Order.order_statuses.keys }
end
