class HomeController < ApplicationController
  def index
    @title = "Royal Chinese Restaurant | Home"
  end

  def menu
    @title = "Royal Chinese Restaurant | Menu"
  end

  def contact_us
    @title = "Royal Chinese Restaurant | Contact Us"
  end

  def about_us
    @title = "Royal Chinese Restaurant | About Us"
  end
end
