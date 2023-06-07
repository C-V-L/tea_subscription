class Tea < ApplicationRecord
  validates_presence_of :title, :description, :temp, :brew_time

  has_many :subscriptions
  has_many :customers, through: :subscriptions
end
