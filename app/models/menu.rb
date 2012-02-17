class Menu < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true
  validates :price, presence: true

  has_attached_file :image, default_url: "/images/default_menu_image.png"
  validates_attachment_size :image, less_than: 1.megabytes
  validates_attachment_content_type :image, content_type: /image\/.+/
end
