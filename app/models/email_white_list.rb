class EmailWhiteList < ActiveRecord::Base
  validates :email, uniqueness: {case_sensitive: false}, presence: true

  def self.include?(email)
    EmailWhiteList.find_by_email(email)
  end
end
