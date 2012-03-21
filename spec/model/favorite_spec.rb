require "spec_helper"

describe Favorite do
  it {should validate_presence_of(:ip_address)}
  it {should validate_presence_of(:menu_id)}
  it {should respond_to :menu}

  describe "IP address validation" do
    it {should allow_value('0.0.0.0').for(:ip_address)}
    it {should allow_value('192.168.1.23').for(:ip_address)}
    it {should_not allow_value('01.10.0.0').for(:ip_address)}
    it {should_not allow_value('0').for(:ip_address)}
    it {should_not allow_value('0.').for(:ip_address)}
    it {should_not allow_value('0.0').for(:ip_address)}
    it {should_not allow_value('0.0.').for(:ip_address)}
    it {should_not allow_value('0.0.0').for(:ip_address)}
    it {should_not allow_value('0.0.0.').for(:ip_address)}
    it {should_not allow_value('abcd').for(:ip_address)}
    it {should_not allow_value('abcd.ab.bc.dc').for(:ip_address)}
    it {should_not allow_value('1923.131.1.1').for(:ip_address)}
    it {should_not allow_value('192,131,1,1').for(:ip_address)}
    it {should_not allow_value('&^&%&&&UU').for(:ip_address)}
  end

  it "should be able to get records created today" do
    old_favorite = Factory(:favorite)
    old_favorite.created_at = 1.days.ago
    old_favorite.save!

    favorite = Factory(:favorite)
    Favorite.today.should include favorite
    Favorite.today.should_not include old_favorite
  end

  it "should not allow mark a menu as favorite twice in a day" do
    favorite = Factory(:favorite, ip_address: '192.168.1.1')
    favorite_twice = Factory.build(:favorite, menu: favorite.menu, ip_address: '192.168.1.1')
    favorite_twice.should_not be_valid
  end

  it "should allow mark different menus as favorite in a day" do
    Factory(:favorite, ip_address: '192.168.1.1')
    favorite_twice = Factory.build(:favorite, menu: Factory(:menu), ip_address: '192.168.1.1')
    favorite_twice.should be_valid
  end

  it "should allow mark a menus as favorite from different ip address in a day" do
    favorite = Factory(:favorite, ip_address: '192.168.1.1')
    favorite_twice = Factory.build(:favorite, menu: favorite.menu, ip_address: '192.168.1.2')
    favorite_twice.should be_valid
  end

  it "should allow mark a menu as favorite twice in different days" do
    favorite = Factory(:favorite, ip_address: '192.168.1.1')
    favorite.created_at = 1.days.ago
    favorite.save!

    favorite_twice = Factory.build(:favorite, menu: favorite.menu, ip_address: '192.168.1.1')
    favorite_twice.should be_valid
  end
end
