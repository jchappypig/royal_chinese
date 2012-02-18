require "spec_helper"

describe Menu do
  describe "validate" do
    let(:menu) {Menu.new}

    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:category)}
    it {should validate_presence_of(:price)}

    it { should have_attached_file(:image) }
    it { should validate_attachment_content_type(:image).
                    allowing('image/png', 'image/gif', 'image/jpeg').
                    rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:image).less_than(2.megabytes) }
  end
end