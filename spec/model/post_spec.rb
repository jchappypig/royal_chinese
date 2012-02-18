require "spec_helper"

describe Post do
  describe "validate" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:is_valid) }
    specify { Post.new.is_valid.should be_true }
  end
end