class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  searchable do
    text :title, :content
  end
end
