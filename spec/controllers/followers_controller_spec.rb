require 'spec_helper'

describe FollowersController do

  context "not authenticated user" do
    it "should not allow user access'" do
      get :index
      should_deny_access
    end

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

    private

    def should_deny_access
      response.should redirect_to new_user_session_path
      flash[:alert].should == "You need to sign in or sign up before continuing."
    end
  end

  context "authenticated user" do
    before :each do
      user = Factory(:user)
      sign_in :user, user
    end

    describe "GET 'index'" do
      it "should response successfully" do
        Factory(:follower)
        get :index
        response.should be_success
        assigns(:followers).count.should == 1
      end
    end

  end
end

