class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:our_menu, :our_location]

  def our_menu
    @title = "Our Menu"
    @menus = Menu.all
  end

  def our_location
    @title = "Our Location"
    @json = Address.all.to_gmaps4rails
  end

  def admin
  end
end
