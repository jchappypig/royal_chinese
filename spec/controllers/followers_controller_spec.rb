require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/priority_control'

describe FollowersController do
  include Shoulda::Matchers::ActionMailer
  include PriorityControl

  context "not authenticated user" do
    it "should not allow user access'" do
      get :index
      should_deny_access

      follower = Factory(:follower)
      delete :destroy, id: follower
      should_deny_access

      get :search
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

    describe "POST 'subscribe'" do

      describe "update" do
        before :each do
          @follower = Factory(:follower, is_subscribe: false, name: 'Huanhuan')
        end

        it "should update follower if already subscribed before" do
          Follower.count.should == 1
          @follower.is_subscribe.should be_false
          @follower.name.should == 'Huanhuan'

          post :subscribe, follower: @follower.attributes.merge(name: 'Harrison'), format: 'js'
          Follower.count.should == 1
          @follower = Follower.find_by_email_ignore_case(@follower.email)
          @follower.is_subscribe.should be_true
          @follower.name.should == 'Harrison'

          response.should render_template :subscribe

          should_not have_sent_email.from('royal_chinese@hotmail.com')
        end

        it "should not update follower if invalid" do
          post :subscribe, follower: @follower.attributes.merge(name: ''), format: 'js'
          @follower = Follower.find_by_email_ignore_case(@follower.email)
          @follower.is_subscribe.should be_false
          @follower.name.should == 'Huanhuan'

          response.should render_template :subscribe
        end
      end

      describe "create" do
        it "should create follower and send follower thank you letter if valid" do
          follower = Factory.build(:follower)

          delayed_job = mock
          mailer_job = mock
          mailer_job.should_receive(:deliver)
          delayed_job.should_receive(:thank_you_subscribing).and_return(mailer_job)
          CustomerMailer.stub(:delay).and_return(delayed_job)

          Follower.count.should == 0

          post :subscribe, follower: follower.attributes, format: 'js'

          Follower.count.should == 1
          response.should render_template :subscribe
        end

        it "should not create follower if invalid" do
          Follower.count.should == 0
          post :subscribe, follower: Factory.build(:follower, name: '').attributes, format: 'js'
          Follower.count.should == 0

          response.should render_template :subscribe
        end
      end
    end

    describe "GET 'unsubscribing'" do
      it "should response successfully"  do
        get :unsubscribing
        assigns(:follower).should be_kind_of(Follower)
        response.should render_template :unsubscribing
      end
    end

    describe "POST 'unsubscribed'" do
      before :each do
        @follower = Factory(:follower)
      end

      it "should unsubscribe newsletter if email is found" do
        post :unsubscribe, follower: @follower.attributes
        @follower = Follower.find_by_email_ignore_case(@follower.email)

        @follower.is_subscribe.should be_false
        flash[:notice].should == 'You have successfully unsubscribed to our newsletter.'
        response.should redirect_to root_path
      end

      it "should not unsubscribe newsletter if email is not found" do
        post :unsubscribe, follower: @follower.attributes.merge(email: 'random@email.com')
        @follower = Follower.find_by_email_ignore_case(@follower.email)

        @follower.is_subscribe.should be_true
        flash[:alert].should == 'Sorry, you have not subscribed to our newsletter'
        response.should render_template :unsubscribing
      end
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

    describe "GET 'search'" do
      it "should search followers" do
        page = '1'
        query = 'jchappypig@hotmail.com'

        search_collections = mock
        search_results = mock
        search_collections.should_receive(:results).and_return(search_results)
        Search::FollowerSearch.should_receive(:execute).with(query, page).and_return(search_collections)

        get :search, page: page, query: query

        assigns(:followers).should == search_results
      end
    end

  end
end

