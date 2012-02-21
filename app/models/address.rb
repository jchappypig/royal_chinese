class Address < ActiveRecord::Base
  acts_as_gmappable

  def gmaps4rails_address
    "35 Flinders Street, Wollongong, NSW 2500"
  end
end
