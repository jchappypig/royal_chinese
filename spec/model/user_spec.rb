require "spec_helper"

describe User do
  describe "validate presence" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe "validate presence" do
    it { should allow_mass_assignment_of(:first_name) }
    it { should allow_mass_assignment_of(:last_name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
  end

  describe "validate uniqueness" do
    before :each do
      pending "Create a user take a long time, need to look into this."
    end

    it "should not allow duplicate email" do
      #@user.save.should be_true
      #another_user = Factory.build(:user, email: @user.email)
      #another_user.should_not be_valid
    end
  end
end