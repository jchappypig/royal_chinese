class Menu < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true
  validates :price, presence: true
  validates :dish_type, presence: true

  has_attached_file :image, styles: { thumbnail: '160x120>',  medium: '260x180>', large: '360x268>' },
                    default_url: '/assets/images/rails.png',
                    url: '/assets/images/menus/:id/:style/:basename.:extension',
                    path: ':rails_root/public/assets/images/menus/:id/:style/:basename.:extension',
                    storage: :s3,
                    bucket: ENV['S3_BUCKET_NAME'],
                    s3_credentials: {
                        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
                    }
  validates_attachment_size :image, less_than: 2.megabytes
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif']

  has_many :favorites
end
