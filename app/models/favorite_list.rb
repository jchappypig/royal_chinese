class FavoriteList < ActiveRecord::Base
  @ip_regex =  /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/
  validates :ip_address, presence: true, format: { with: @ip_regex }

  belongs_to :menu
end
