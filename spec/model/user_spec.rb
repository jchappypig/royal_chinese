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
      @user = Factory.build(:user, email: "email@email.com")
    end

    it "should not allow duplicate email regardless case" do
      @user.save.should be_true
      another_user = Factory.build(:user, email: @user.email.capitalize)
      another_user.should_not be_valid
    end

    it "should allow different email" do
      another_user = Factory.build(:user, email: "another_email@email.com")
      another_user.should be_valid
    end
  end
end