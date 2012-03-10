class FollowersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :create]

  def index
    @followers = Follower.all
  end

  def new
    @follower = Follower.new
    render 'home/index'
  end

  def create
    @follower = Follower.new(params[:follower])

    if Follower.find_by_email_ignore_case(@follower.email)
      redirect_to root_path, notice: 'You have successfully subscribed to our newsletter.'
    elsif @follower.save
      redirect_to root_path, notice: 'You have successfully subscribed to our newsletter.'
      CustomerMailer.thank_you_subscribing(@follower).deliver
    else
      render 'home/index'
    end
  end

  def destroy
    @follower = Follower.find(params[:id])
    @follower.destroy

    redirect_to followers_url
  end
end