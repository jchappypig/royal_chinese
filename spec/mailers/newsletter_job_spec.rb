require 'spec_helper'

describe NewsletterJob do
  it "should subscribe newsletter in batches" do
    4.times {Factory(:follower)}
    2.times {Factory(:follower, is_subscribe: false)}
    subscribing_followers_emails = Follower.scoped_by_is_subscribe(true).map(&:email)
    newsletter = Factory(:post)

    newsletter_job = NewsletterJob.new(newsletter)
    newsletter_job.stub(:batch_size).and_return(2)
    CustomerMailer.should_receive(:subscribe_newsletter).once.with(newsletter, subscribing_followers_emails[0..1])
    CustomerMailer.should_receive(:subscribe_newsletter).once.with(newsletter, subscribing_followers_emails[2..3])
    newsletter_job.perform
  end
end