class Favorite < ActiveRecord::Base
  @ip_regex =  /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/
  validates :ip_address, presence: true, format: { with: @ip_regex }
  validates :menu_id, presence: true

  belongs_to :menu
  validates_associated :menu

  #scope :today, where("DATE(created_at) = DATE(?)", Time.now)
  #validate :cannot_mark_twice_in_one_day, on: :create
  #
  #def cannot_mark_twice_in_one_day
  #  errors.add(:base, "cannot mark twice in a day") if Favorite.today.find_by_menu_id_and_ip_address(menu_id, ip_address)
  #end
end
