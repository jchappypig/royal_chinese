module RegistrationHelper
  def register(options={})
    options[:first_name] ||= "Huanhuan"
    options[:last_name] ||= "Huang"
    options[:email] ||= "jchappypig@hotmail.com"
    options[:password] ||= "123456"
    options[:password_confirmation] ||= "123456"

    Factory(:email_white_list, email: options[:email])

    visit new_user_registration_path

    fill_in "user_first_name", with: "Huanhuan"
    fill_in "user_last_name", with: "Huang"
    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_button "Sign up"
  end

  def sign_in(options={})
    visit new_user_session_path
    options[:email] ||= "jchappypig@hotmail.com"
    options[:password] ||= "123456"

    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "123456"
    click_button "Sign in"
  end
end