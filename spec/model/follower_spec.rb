require "spec_helper"

describe Follower do
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:email)}

  specify { Follower.new.is_subscribe.should be_true }
end