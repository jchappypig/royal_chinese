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

  describe "#include?" do
    specify {EmailWhiteList.find_by_email_ignore_case(@email_white_list.email).should_not be_nil}
    specify {EmailWhiteList.find_by_email_ignore_case('random_mail@hotmail.com').should be_nil}
  end
end