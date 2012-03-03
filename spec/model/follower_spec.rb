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

    it { should validate_uniqueness_of(:email) }
  end

end