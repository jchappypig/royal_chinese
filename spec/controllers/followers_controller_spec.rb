require 'spec_helper'

describe FollowersController do
  describe "GET 'new'" do
    it "should response successfully" do
      get :new
      response.should be_success
      assigns(:follower).should be_kind_of(Follower)
      response.should render_template root_path
    end
  end

  describe "Follower 'create'" do
    it "should save follower if valid" do
      Follower.count.should == 0
      post :create, follower: Factory.build(:follower).attributes
      Follower.count.should == 1

      flash[:notice].should == 'You have successfully subscribed to our newsletter.'
      response.should redirect_to root_path
    end

    it "should not save follower if invalid" do
      Follower.count.should == 0
      post :create, follower: Factory.build(:follower, name: "").attributes
      Follower.count.should == 0

      response.should render_template root_path
    end
  end
end

