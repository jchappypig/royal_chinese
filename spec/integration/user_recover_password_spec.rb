require 'spec_helper'
require 'email_spec'
require File.dirname(__FILE__) + '/helpers/registration_helper'

include RegistrationHelper
include EmailSpec::Helpers

describe "User recover password" do

  it "should allow user to reset forgotten password" do
    register email: "jchappypig@hotmail.com"
    click_link "Logout"

    visit new_user_session_path
    click_link "Forgot your password?"

    fill_in "user_email", with: "jchappypig@hotmail.com"
    click_button "Send me reset password instructions"

    open_last_email_for("jchappypig@hotmail.com")
    click_first_link_in_email

    page.should have_content("Change your password")
    fill_in "user_password", with: "654321"
    fill_in "user_password_confirmation", with: "654321"
    click_button "Change my password"
    find(".alert-error").should have_content("Your password was changed successfully")
    click_link "Logout"

    click_link "Sign in"
    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "654321"
    click_button "Sign in"
    find(".alert-error").should have_content("Signed in successfully.")
  end
end