class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @title = "Home"
  end

  def our_menu
    @title = "Our Menu"
  end

  def contact_us
    @title = "Contact Us"
    @json = Address.all.to_gmaps4rails
  end

  def about_us
    @title = "About Us"
  end
end
