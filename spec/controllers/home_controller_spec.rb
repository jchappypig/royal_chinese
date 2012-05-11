require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/priority_control'

describe HomeController do
  include PriorityControl

  context "not authenticated user" do
    describe "GET 'our menu'" do
      before :each do
        get :our_menu
      end

      specify { response.should be_success }
      specify { assigns(:title).should == "Our Menu" }
    end

    describe "GET :our location" do
      before :each do
        get :our_location
      end

      specify { response.should be_success }
      specify { assigns(:title).should == "Our Location" }
    end

    describe "GET :admin" do
      specify {get :admin; should_deny_access}
    end
  end

  context "authenticated user" do
    before :each do
      user = Factory(:user)
      sign_in :user, user
    end

    describe "GET :admin" do
      specify {get :admin; response.should render_template :admin}
    end
  end
end
