require 'spec_helper'

describe FollowersController do
  describe "GET 'new'" do
    it "should response successfully" do
      get :new
      response.should be_success
      assigns(:follower).should be_kind_of(Follower)
      response.should render_template 'home/index'
    end
  end
end

