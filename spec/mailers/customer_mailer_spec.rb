require 'spec_helper'

describe CustomerMailer do
  it "should send customer thank you for subscribing letter" do
    follower = Factory(:follower)
    thank_you_subscribing_email = CustomerMailer.thank_you_subscribing(follower).deliver
    thank_you_subscribing_email.subject.should == 'Thank you for subscribing'
    thank_you_subscribing_email.to.should == [follower.email]
    thank_you_subscribing_email.from.should == ['royal_chinese@hotmail.com']
    thank_you_subscribing_email.header['From'].to_s.should include 'Royal Chinese'
  end
end