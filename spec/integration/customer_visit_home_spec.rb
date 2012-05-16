require 'spec_helper'

describe "customer visit home page", type: :request do
  before :each do
    visit root_path
  end

  it "should have key menus" do
    page.should have_content("Our Menu")
    page.should have_content("Our Location")
    page.should have_content("Home")

    click_on "Our Menu"
    page.current_path.should == our_menu_path
    page.should have_selector("title", content: "Our Menu")

    click_on "Our Location"
    page.current_path.should == our_location_path
    page.should have_selector("title", content: "Our Location")

    click_on "Home"
    page.current_path.should == root_path
    page.should have_selector("title", content: "home")
  end
end