class Menu < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true
  validates :price, presence: true

  has_attached_file :image
  validates_attachment_size :image, less_than: 1.megabytes
  validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg']
end
