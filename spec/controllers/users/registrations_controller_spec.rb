require 'spec_helper'

describe Users::RegistrationsController do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  let(:user) {Factory.build(:user)}

  it "should allow user to register if in the white list" do
    EmailWhiteList.stub(:include?).and_return(true)
    post :create, user: Factory.attributes_for(:user)
    flash[:notice].should == "Welcome! You have signed up successfully."
  end

  it "should not allow user to register if not in the white list" do
    post :create, user: user.attributes
    flash[:alert].should == "Hey, you are not allow to register. Please ask admin for permission."
    response.should redirect_to root_path
  end
end