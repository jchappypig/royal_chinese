require "spec_helper"

describe Menu do
  describe "validate" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:category)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:dish_type)}
    it {should respond_to(:favorites)}

    it { should have_attached_file(:image) }
    it { should validate_attachment_content_type(:image).
                    allowing('image/png', 'image/gif', 'image/jpeg').
                    rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:image).less_than(2.megabytes) }

    Menu::DISH_TYPES.each do |dish_type|
      it { should allow_value(dish_type).for(:dish_type)}
    end
  end
end