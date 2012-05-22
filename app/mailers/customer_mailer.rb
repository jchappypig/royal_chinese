class CustomerMailer < ActionMailer::Base
  include SendGrid
  include ApplicationHelper

  def thank_you_subscribing(follower)
    setup_company_info
    @follower = follower
    mail(to: @follower.email, subject: 'Thank you for subscribing', from: company_contact_email_with_name)
  end

  def subscribe_newsletter(newsletter, followers)
    setup_company_info
    sendgrid_category :use_subject_lines
    sendgrid_enable   :ganalytics, :opentracking
    sendgrid_recipients followers.map(&:email)
    sendgrid_substitute '___name___', followers.map(&:name)

    @content = newsletter.content.to_s
    mail(to: 'jchappypig@hotmail.com', subject: newsletter.title, from: company_contact_email_with_name)
  end

  private

  def setup_company_info
    @company_full_name = company_full_name
    @company_address = company_address
    @company_phone = company_phone
  end
end
