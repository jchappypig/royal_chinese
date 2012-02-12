class HomeController < ApplicationController
  def index
    @title = "Home"
  end

  def menu
    @title = "Menu"
  end

  def contact_us
    @title = "Contact Us"
  end

  def about_us
    @title = "About Us"
  end
end
