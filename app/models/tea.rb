class Tea < ApplicationRecord
  validates_presence_of :title, :description, :temp, :brew_time

  has_many :subscription_teas, dependent: :destroy
  has_many :subscriptions, through: :subscription_teas
  has_many :customers, through: :subscriptions
end
