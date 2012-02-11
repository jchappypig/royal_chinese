require "spec_helper"

describe User do
  describe "validate" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    it { should allow_mass_assignment_of(:email)}
    it { should allow_mass_assignment_of(:password) }

    it "should check uniqueness of email" do
      user = Factory(:user)
      user.should validate_uniqueness_of(:email)
    end
  end
end