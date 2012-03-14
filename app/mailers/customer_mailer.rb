class CustomerMailer < ActionMailer::Base
  include SendGrid
  default from: "\"Royal Chinese\" <royal_chinese@hotmail.com>"

  def thank_you_subscribing(follower)
    @follower = follower
    mail(to: @follower.email, subject: "Thank you for subscribing")
  end

  def subscribe_newsletter(newsletter, followers)
    sendgrid_category :use_subject_lines
    sendgrid_enable   :ganalytics, :opentracking
    sendgrid_recipients followers.map(&:email)
    sendgrid_substitute '___name___', followers.map(&:name)

    @content = newsletter.content.to_s
    mail(to: "hhuang@thoughtworks.com", subject: newsletter.title)
  end
end
