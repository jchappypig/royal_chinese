require 'spec_helper'

describe CustomerMailer do
  it "should send customer thank you for subscribing letter" do
    follower = Factory(:follower)

    thank_you_subscribing_email = CustomerMailer.thank_you_subscribing(follower).deliver

    thank_you_subscribing_email.subject.should == 'Thank you for subscribing'
    thank_you_subscribing_email.to.should == [follower.email]
    should_from_royal_chinese(thank_you_subscribing_email)
  end

  it "should send subscribing followers newsletter" do
    newsletter = Factory(:post)
    follower = Factory(:follower)
    another_follower = Factory(:follower)

    newsletter_email = CustomerMailer.subscribe_newsletter(newsletter, [follower, another_follower]).deliver

    newsletter_email.subject.should == newsletter.title
    newsletter_email.to.should_not be_nil
    newsletter_email.body.should include newsletter.content
    header_json = JSON.parse(newsletter_email.header['X-SMTPAPI'].value)
    header_json['to'].should =~ [follower.email, another_follower.email]
    header_json['sub']['___name___'] =~ [follower.name, another_follower.name]
    should_from_royal_chinese(newsletter_email)
  end

  private

  def should_from_royal_chinese(email)
    email.from.should == ['royal_chinese@hotmail.com']
    email.header['From'].to_s.should include 'Royal Chinese'
  end
end