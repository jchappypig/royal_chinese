require "spec_helper"

describe FavoriteList do
  it {should validate_presence_of(:ip_address)}
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
end
