require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/registration_helper'

include RegistrationHelper

describe "user sign up and sign in" do

  it "should allow user to sign up and sign in" do
    register email: "jchappypig@hotmail.com", password: "123456", password_confirmation: "123456"

    find(".alert-success").should have_content("Welcome! You have signed up successfully.")
    click_link "Logout"
    find(".alert-success").should have_content("Signed out successfully.")

    click_link "Sign in"
    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "123456"

    click_button "Sign in"
    find(".alert-success").should have_content("Signed in successfully.")

  end
end