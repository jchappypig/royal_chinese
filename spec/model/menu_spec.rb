require "spec_helper"

describe Menu do
  describe "validate" do
    let(:menu) {Menu.new}

    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:category)}
    it {should validate_presence_of(:price)}
  end
end