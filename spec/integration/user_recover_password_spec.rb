require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/registration_helper'

include RegistrationHelper

describe "User recover password" do

  it "should allow user to reset forgotten password" do
    register email: "jchappypig@hotmail.com"
    click_link "Logout"

    visit new_user_session_path
    click_link "Forgot your password?"

    fill_in "user_email", with: "jchappypig@hotmail.com"
    click_button "Send me reset password instructions"
  end
end