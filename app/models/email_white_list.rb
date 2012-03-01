class EmailWhiteList < ActiveRecord::Base
  validates :email, uniqueness: {case_sensitive: false}, presence: true, email: true

  def self.find_by_email_ignore_case(email)
    EmailWhiteList.where("LOWER(email) = ?", email.to_s.downcase).first
  end

end
