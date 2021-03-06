class FollowersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :subscribe, :create, :update, :unsubscribing, :unsubscribe]

  def index
    @followers = Follower.paginate(page: params[:page])
  end

  def search
    @followers = Search::FollowerSearch.execute(params[:query], params[:page]).results
    render :index
  end

  def new
    @title = 'Home'
    @follower = Follower.new
    @posts = Post.scoped_by_is_valid(true).limit(5).order('updated_at DESC')
    render 'home/index'
  end

  def subscribe
    Follower.find_by_email_ignore_case(params[:follower][:email])? update : create
  end

  def unsubscribing
    @follower = Follower.new
  end

  def unsubscribe
    @follower = Follower.find_by_email_ignore_case(params[:follower][:email])

    if @follower
      @follower.is_subscribe = false
      @follower.save!
      redirect_to root_path, notice: 'You have successfully unsubscribed to our newsletter.'
    else
      flash.now.alert = 'Sorry, you have not subscribed to our newsletter'
      render :unsubscribing
    end
  end

  def destroy
    @follower = Follower.find(params[:id])
    @follower.destroy

    redirect_to followers_url
  end

  private

  def create
    @follower = Follower.new(params[:follower])
    CustomerMailer.delay.thank_you_subscribing(@follower).deliver if @follower.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @follower = Follower.find_by_email_ignore_case(params[:follower][:email])
    @follower.name = params[:follower][:name]
    @follower.is_subscribe = true

    @follower.save
    respond_to do |format|
        format.js
    end
  end
end