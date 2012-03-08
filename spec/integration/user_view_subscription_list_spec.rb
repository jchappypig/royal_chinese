require 'spec_helper'
include Warden::Test::Helpers

describe "user view subscription list" do
  before :each do
    Warden.test_mode!
    user = Factory(:user)
    login_as(user, scope: :user)
  end

  it "should allow user to view the list" do

    visit followers_path
    page.should_not have_selector("table#followers")
    page.should have_content("Sorry, no followers found.")

    Factory(:follower)
    visit followers_path
    page.should have_selector("table#followers")
    page.all("tr.follower").count.should == 1

    Factory(:follower)
    visit followers_path
    page.should have_selector("#followers")
    page.all("tr.follower").count.should == 2
  end

  after :each do
    Warden.test_reset!
  end
end