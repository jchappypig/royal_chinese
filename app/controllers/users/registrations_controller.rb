class Users::RegistrationsController < Devise::RegistrationsController
  def create
    email = params[:user][:email]
    email.blank? || EmailWhiteList.include?(email) ?
        super : (redirect_to root_path, alert: "Hey, you are not allow to register. Please ask admin for permission.")
  end
end