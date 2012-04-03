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

    describe "GET :contact_us" do
      before :each do
        get :contact_us
      end

      specify { response.should be_success }
      specify { assigns(:title).should == "Contact Us" }
    end

    describe "GET :about_us" do
      before :each do
        get :about_us
      end

      specify { response.should be_success }
      specify { assigns(:title).should == "About Us" }
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
