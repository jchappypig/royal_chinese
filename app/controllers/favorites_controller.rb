class FavoritesController  < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create]

  def create
    @favorite = Favorite.new(params[:favorite])
    @favorite.ip_address = request.remote_ip
    if @favorite.save
      respond_to do |format|
        format.json { render json: {}, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: {message: @favorite.errors.full_messages.join(". ")}, status: :not_acceptable }
      end
    end
  end
end