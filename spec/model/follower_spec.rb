require "spec_helper"

describe Follower do
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:email)}
end