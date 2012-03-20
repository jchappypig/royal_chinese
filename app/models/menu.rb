class Menu < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true
  validates :price, presence: true
  validates :dish_type, presence: true

  has_attached_file :image, styles: { thumbnail: '160x120>',  medium: '260x180>', large: '360x268>' },
                    default_url: '/assets/images/rails.png',
                    url: '/assets/images/menus/:id/:style/:basename.:extension',
                    path: ':rails_root/public/assets/images/menus/:id/:style/:basename.:extension'
  validates_attachment_size :image, less_than: 2.megabytes
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif']

  has_many :favorite_lists
end
