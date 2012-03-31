require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/registration_helper'

include RegistrationHelper

describe "user sign up and sign in" do

  it "should allow user to sign up and sign in" do
    register email: "jchappypig@hotmail.com", password: "123456", password_confirmation: "123456"

    find(".alert-success").should have_content("Welcome! You have signed up successfully.")
    page.current_path.should == user_root_path

    click_link "Logout"
    find(".alert-success").should have_content("Signed out successfully.")
    page.current_path.should == root_path

    visit new_user_session_path
    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "123456"

    click_button "Sign in"
    find(".alert-success").should have_content("Signed in successfully.")
    page.current_path.should == user_root_path

  end
end