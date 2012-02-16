require "spec_helper"

describe EmailWhiteList do
  describe "#include?" do
    specify {EmailWhiteList.include?("jchappypig@hotmail.com").should be_true}
    specify {EmailWhiteList.include?("random_mail@hotmail.com").should be_false}
  end
end