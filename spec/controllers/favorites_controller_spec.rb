require 'spec_helper'

describe FavoritesController do
  describe "Post 'create'" do
    it "should save favorite if valid" do
      Favorite.count.should == 0
      post :create, favorite: Favorite.new(menu: Factory(:menu)).attributes, format: 'json'
      Favorite.count.should == 1
      response.body.should == '{}'
    end

    it "should not save favorite if invalid" do
      menu = Factory(:menu)
      post :create, favorite: Favorite.new(menu: menu).attributes, format: 'json'
      Favorite.count.should == 1
      post :create, favorite: Favorite.new(menu: menu).attributes, format: 'json'
      Favorite.count.should == 1
      JSON.parse(response.body)['message'].should_not be_nil
    end
  end
end