class FollowersController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
    @follower = Follower.new
    render 'home/index'
  end

  def subscribe
    new
  end

  def create
    @follower = Follower.new(params[:follower])

    if @follower.save
      redirect_to root_path, notice: 'You have successfully subscribed to our newsletter.'
    else
      render 'home/index'
    end
  end

  def edit
    @follower = Follower.find(params[:id])
    render 'home/index'
  end

  def update
    @follower = Follower.find(params[:id])

    if @follower.update_attributes(params[:follower])
      redirect_to root_path, notice: 'You have successfully subscribed to our newsletter.'
    else
      render 'home/index'
    end
  end
end