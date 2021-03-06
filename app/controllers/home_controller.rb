class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:our_menu, :our_location]

  def our_menu
    @dish_type = params[:dish_type] || Menu::DISH_TYPES.first
    @menus = Menu.where('dish_type = ?', @dish_type).paginate(page: params[:page], per_page: 9)
  end

  def our_location
    @json = Address.all.to_gmaps4rails
  end

  def admin
  end
end
