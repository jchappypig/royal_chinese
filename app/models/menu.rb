class Menu < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true
  validates :price, presence: true
end
