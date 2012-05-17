class Menu < ActiveRecord::Base
  DISH_TYPES = ['Stir Fried', 'Hotpot']
  CATEGORIES = ['Meat', 'Seafood', 'Vegetable']

  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :dish_type, presence: true, inclusion: { in: DISH_TYPES}

  has_attached_file :image, { styles: { thumbnail: '260x180>', large: '360x268>' },
                    default_url: '/assets/default_menu.png',
                    url: '/assets/images/menus/:id/:style/:basename.:extension',
                    path: ':rails_root/public/assets/images/menus/:id/:style/:basename.:extension' }
                    .merge(PAPERCLIP_STORAGE_OPTIONS)
  validates_attachment_size :image, less_than: 2.megabytes
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif']

  has_many :favorites
end
