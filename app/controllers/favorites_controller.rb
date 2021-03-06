class FavoritesController  < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create]
  before_filter :load_menu

  def create
    @favorite = @menu.favorites.create(ip_address: request.remote_ip)
    respond_to do |format|
      format.js
    end
  end

  private

  def load_menu
    @menu = Menu.find_by_id!(params[:menu_id])
  end
end