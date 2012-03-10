require 'spec_helper'

describe FollowersController do
  include Shoulda::Matchers::ActionMailer

  context "not authenticated user" do
    it "should not allow user access'" do
      get :index
      should_deny_access

      follower = Factory(:follower)
      delete :destroy, id: follower
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
      it "should ignore create request but show subscribe successfully if already subscribed before" do
        follower = Factory.build(:follower)
        follower.save!
        Follower.count.should == 1

        post :create, follower: follower.attributes
        Follower.count.should == 1

        flash[:notice].should == 'You have successfully subscribed to our newsletter.'
        response.should redirect_to root_path
      end

      it "should save follower and send follower thank you letter if valid" do
        Follower.count.should == 0
        follower = Factory.build(:follower)
        post :create, follower: follower.attributes
        Follower.count.should == 1

        flash[:notice].should == 'You have successfully subscribed to our newsletter.'
        response.should redirect_to root_path

        should have_sent_email.from('royal_chinese@hotmail.com')
        should have_sent_email.to(follower.email)
        should have_sent_email.with_subject('Thank you for subscribing')
        should have_sent_email.with_body(/#{follower.name}/)
        should have_sent_email.with_body(/Thank you for subscribing/)
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

    describe "Delete 'destroy'" do
      it "should destroy follower" do
        follower = Factory(:follower)
        Follower.count.should == 1
        delete :destroy, id: follower
        Follower.count.should == 0

        response.should redirect_to followers_path
      end
    end

  end
end

