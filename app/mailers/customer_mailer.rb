class CustomerMailer < ActionMailer::Base
  default from: "\"Royal Chinese\" <royal_chinese@hotmail.com>"

  def thank_you_subscribing(follower)
    @follower = follower
    mail(:to => @follower.email, :subject => "Thank you for subscribing")
  end
end
