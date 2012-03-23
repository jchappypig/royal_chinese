class Menu < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true
  validates :price, presence: true
  validates :dish_type, presence: true

  has_attached_file :image, Rails.configuration.paper_clip_options
  validates_attachment_size :image, less_than: 2.megabytes
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif']

  has_many :favorites
end
