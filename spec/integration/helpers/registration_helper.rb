module RegistrationHelper
  def register(options={})
    options[:first_name] ||= "Huanhuan"
    options[:last_name] ||= "Huang"
    options[:email] ||= "jchappypig@hotmail.com"
    options[:password] ||= "123456"
    options[:password_confirmation] ||= "123456"

    visit root_path
    click_link "Sign up"

    fill_in "user_first_name", with: "Huanhuan"
    fill_in "user_last_name", with: "Huang"
    fill_in "user_email", with: "jchappypig@hotmail.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_button "Sign up"
  end
end