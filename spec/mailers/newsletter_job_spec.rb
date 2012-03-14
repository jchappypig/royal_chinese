require 'spec_helper'

describe NewsletterJob do
  it "should subscribe newsletter in batches" do
    4.times {Factory(:follower)}
    2.times {Factory(:follower, is_subscribe: false)}
    subscribing_followers = Follower.scoped_by_is_subscribe(true)
    newsletter = Factory(:post)

    newsletter_job = NewsletterJob.new(newsletter)
    newsletter_job.stub(:batch_size).and_return(2)
    mail = mock()
    mail.should_receive(:deliver)
    another_mail = mock()
    another_mail.should_receive(:deliver)
    CustomerMailer.should_receive(:subscribe_newsletter).once.with(newsletter, subscribing_followers[0..1]).and_return(mail)
    CustomerMailer.should_receive(:subscribe_newsletter).once.with(newsletter, subscribing_followers[2..3]).and_return(another_mail)
    newsletter_job.perform
  end
end