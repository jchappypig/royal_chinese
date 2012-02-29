class FollowersController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
    @follower = Follower.new
    render "home/index"
  end
  #
  #def create
end