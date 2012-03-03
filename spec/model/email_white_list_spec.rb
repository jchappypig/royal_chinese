require "spec_helper"

describe EmailWhiteList do
  before :each do
    @email_white_list = Factory(:email_white_list)
  end

  it {should validate_uniqueness_of(:email).case_insensitive}
  it {should validate_presence_of(:email)}

  describe "email validation" do
    it { should allow_value('jchappypig@hotmail.com').for(:email) }
    it { should allow_value('hhuang@thoughtworks.com').for(:email) }
    it { should allow_value('UPPERCASE@HOTMAIL.COM').for(:email) }
    it { should_not allow_value('hhuang@hotmail').for(:email) }
    it { should_not allow_value('hhuang.com.hotmail').for(:email) }
    it { should_not allow_value('@com.hotmail').for(:email) }
    it { should_not allow_value('~~@@@@@@hotmail.com').for(:email)}
    it { should_not allow_value('^^&&@hotmail.com').for(:email)}
  end

  describe "#find_by_email_ignore_case" do

    it "should be able to find the white list by email ignore case" do
      EmailWhiteList.find_by_email_ignore_case(@email_white_list.email).should == @email_white_list
      EmailWhiteList.find_by_email_ignore_case(@email_white_list.email.capitalize).should == @email_white_list
    end

    it "should not find the white list if the email address is different" do
      EmailWhiteList.find_by_email_ignore_case("random@email.com").should_not == @email_white_list
    end
  end
end