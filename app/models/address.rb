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
    infowindow =  "<h3>#{name}</h3>"
    infowindow << "<img src='/images/ziqi.jpg' width='100px' align='left'>"
    infowindow << "<h4>Open Hour:</h4>"
    infowindow << "<p><dd><b>Monday to Sunday</b><dd></p>"
    infowindow << "<dd>6:00pm - 10:00pm</dd>"
  end
end
