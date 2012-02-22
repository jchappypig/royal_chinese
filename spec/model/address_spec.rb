require "spec_helper"

describe Address do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }

  let(:address) { Factory(:address) }

  specify { address.gmaps4rails_address.should == address.description }
end