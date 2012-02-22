class Address < ActiveRecord::Base
  acts_as_gmappable

  validates :name, presence: true
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def gmaps4rails_address
    description
  end

  def gmaps4rails_infowindow
    name
  end
end
