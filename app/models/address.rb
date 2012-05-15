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
    infowindow =  "<h3 class='restaurant_name'>#{name}</h3>"
    infowindow << "<div class='row' >"
    infowindow << " <div class='span2 landmark' >"
    infowindow << "   <img src='/assets/flag.png' width='100px' align='left'/>"
    infowindow << " </div>"
    infowindow << " <div class='span2' >"
    infowindow << "   <strong>Open Hour:</strong>"
    infowindow << "   <p/>"
    infowindow << "   <em>Monday to Sunday</em>"
    infowindow << "   <p>11:00am - 02:00pm</p>"
    infowindow << "   <p>05:30pm - 10:00pm</p>"
    infowindow << " </div>"
    infowindow << "</div>"
  end
end
