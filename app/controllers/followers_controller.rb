class FollowersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :subscribe, :create, :update]

  def index
    @followers = Follower.all
  end

  def new
    @follower = Follower.new
    render 'home/index'
  end

  def subscribe
    Follower.find_by_email_ignore_case(params[:follower][:email])? update : create
  end

  def destroy
    @follower = Follower.find(params[:id])
    @follower.destroy

    redirect_to followers_url
  end

  private

  def create
    @follower = Follower.new(params[:follower])

    if @follower.save
      redirect_to root_path, notice: 'You have successfully subscribed to our newsletter.'
      CustomerMailer.thank_you_subscribing(@follower).deliver
    else
      render 'home/index'
    end
  end

  def update
    @follower = Follower.find_by_email_ignore_case(params[:follower][:email])
    @follower.name = params[:follower][:name]
    @follower.is_subscribe = true

    if @follower.save
      redirect_to root_path, notice: 'You have successfully subscribed to our newsletter.'
    else
      render 'home/index'
    end
  end
end