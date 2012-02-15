require "rspec"

describe "user sign up and sign in" do

  it "should allow user to sign up and sign in" do
    visit root_path
    click_link "Sign up"

    fill_in "user_first_name", with: "Huanhuan"
    fill_in "user_last_name", with: "Huang"
    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_button "Sign up"

    find(".alert-error").should have_content("Welcome! You have signed up successfully.")
    click_link "Logout"
    find(".alert-error").should have_content("Signed out successfully.")

    click_link "Sign in"
    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "123456"

    click_button "Sign in"
    find(".alert-error").should have_content("Signed in successfully.")
  end
end