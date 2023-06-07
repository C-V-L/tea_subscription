class Subscription < ApplicationRecord
  validates_presence_of :price, :status, :frequency, :customer_id

  belongs_to :customer
  has_many :subscription_teas, dependent: :destroy
  has_many :teas, through: :subscription_teas
end
