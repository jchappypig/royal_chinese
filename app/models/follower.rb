class Follower < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false},  email: true

  def self.find_by_email_ignore_case(email)
    Follower.where("LOWER(email) = ?", email.to_s.downcase).first
  end

  searchable do
    text :email, :name
  end
end
