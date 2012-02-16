require "spec_helper"

describe EmailWhiteList do
  before :each do
    @email_white_list = Factory(:email_white_list)
  end

  it {should validate_uniqueness_of(:email).case_insensitive}
  it {should validate_presence_of(:email)}

  describe "#include?" do
    specify {EmailWhiteList.include?(@email_white_list.email).should be_true}
    specify {EmailWhiteList.include?("random_mail@hotmail.com").should be_false}
  end
end