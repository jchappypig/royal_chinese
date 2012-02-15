require 'spec_helper'

describe "customer visit home page", type: :request do
  before :each do
    visit root_path
  end

  it "should have key menus" do
    page.should have_content("Our Menu")
    page.should have_content("Contact Us")
    page.should have_content("About Us")

    click_on "Our Menu"
    page.current_path.should == our_menu_path
    page.should have_selector("title", content: "Our Menu")

    click_on "Contact Us"
    page.current_path.should == contact_us_path
    page.should have_selector("title", content: "Contact Us")

    click_on "About Us"
    page.current_path.should == about_us_path
    page.should have_selector("title", content: "About Us")
  end
end