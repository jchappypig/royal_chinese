require 'spec_helper'

include Warden::Test::Helpers

describe "user visit admin" do
  before :each do
    Warden.test_mode!
    user = Factory(:user)
    login_as(user, scope: :user)
  end

  it "should allow user create, updated, delete menus." do
    visit root_path

    click_link "Admin"
    click_link "Menus"
    page.current_path.should == menus_path

    click_link "Admin"
    click_link "Posts"
    page.current_path.should == posts_path

    click_link "Admin"
    click_link "Followers"
    page.current_path.should == followers_path
  end

  after :each do
    Warden.test_reset!
  end
end