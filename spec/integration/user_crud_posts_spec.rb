require 'spec_helper'
include Warden::Test::Helpers

describe "user CRUD posts" do
  before :each do
    Warden.test_mode!
    user = Factory(:user)
    login_as(user, scope: :user)
  end

  it "should allow user create, updated, delete posts." do
    visit posts_path
    page.should have_content "Listing posts"
    page.should have_content "Sorry, no posts found."
    page.should_not have_selector("table#posts")
    click_link "New Post"

    page.should have_content "New post"
    fill_in "post_title", with: "Cabbage is on special!!"
    fill_in "post_content", with: "From 12th Feb - 14th Feb, cabbage is only 2 dollars each"
    uncheck "post_is_valid"
    click_button "Create Post"
    find(".alert-success").should have_content("Post was successfully created.")

    page.should have_content "Cabbage is on special!!"
    page.should have_content "From 12th Feb - 14th Feb, cabbage is only 2 dollars each"
    page.should have_content "false"

    click_link "Edit"
    page.should have_content "Editing post"
    fill_in "post_content", with: "From 12th Feb - 15th Feb, cabbage is only 3 dollars each"
    click_button "Update Post"
    find(".alert-success").should have_content("Post was successfully updated.")

    page.should have_content "From 12th Feb - 15th Feb, cabbage is only 3 dollars each"

    click_link "Back"
    page.current_path.should == posts_path
    page.should have_selector("table#posts")

    page.should have_content("Cabbage")
    click_link "Destroy"
  end

  after :each do
    Warden.test_reset!
  end
end