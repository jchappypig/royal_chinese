class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :is_valid, presence: true
end
