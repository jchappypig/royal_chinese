require 'spec_helper'

describe FollowersController do
  #describe "GET subscribe" do
  #  it "should get new if it's a new follower" do
  #    get :subscribe
  #    controller.should_receive(:new).with(:no_args).once
  #  end
  #end

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


  describe "GET 'edit'" do
    it "should response successfully" do
      @follower = Factory(:follower)
      get :edit, id: @follower
      response.should be_success
      assigns(:follower).should be_kind_of(Follower)
      response.should render_template root_path
    end
  end

  describe "Put 'update'" do
    before :each do
      @follower = Factory(:follower)
    end

    it "should update follower if valid" do
      put :update, id: @follower, follower: @follower.attributes.merge(name: "new name")

      Follower.find_by_id(@follower).name.should == "new name"

      flash[:notice].should == 'You have successfully subscribed to our newsletter.'
      response.should redirect_to root_path
    end

    it "should not update follower if invalid" do
      put :update, id: @follower, follower: @follower.attributes.merge(name: "")

      Follower.find_by_id(@follower).name.should == @follower.name

      response.should render_template root_path
    end
  end


end

