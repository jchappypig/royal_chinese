class FollowersController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:index]

  def index
    @followers = Follower.all
  end

  def new
    @follower = Follower.new
    render 'home/index'
  end

  def create
    @follower = Follower.new(params[:follower])

    if Follower.find_by_email_ignore_case(@follower.email) || @follower.save
      redirect_to root_path, notice: 'You have successfully subscribed to our newsletter.'
    else
      render 'home/index'
    end
  end
end