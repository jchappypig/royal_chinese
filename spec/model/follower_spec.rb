require "spec_helper"

describe Follower do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  it { should_not allow_value('hhuang.com.hotmail').for(:email) }
  it { should_not allow_value('hhuang@hotmail').for(:email) }

  specify { Follower.new.is_subscribe.should be_true }

  describe "validate uniqueness" do
    before :each do
      Factory(:follower)
    end

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe "#find_by_email_ignore_case" do
    before :each do
      @follower = Factory(:follower, email: "jchappypig@hotmail.com")
    end

    it "should be able to find the follower by email ignore case" do
      Follower.find_by_email_ignore_case("jchappypig@hotmail.com").should == @follower
      Follower.find_by_email_ignore_case("JChappypig@hotmail.com").should == @follower
    end

    it "should not find the white list if the email address is different" do
      Follower.find_by_email_ignore_case("random@email.com").should_not == @follower
    end
  end

end