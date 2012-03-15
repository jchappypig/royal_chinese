module PriorityControl
  def should_deny_access
    response.should redirect_to new_user_session_path
    flash[:alert].should == "You need to sign in or sign up before continuing."
  end
end