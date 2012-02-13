require 'spec_helper'

describe HomeController do

  describe "GET :index" do
    before :each do
      get :index
    end

    specify { response.should be_success }
    specify { assigns(:title).should == "Home" }
  end

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

end
