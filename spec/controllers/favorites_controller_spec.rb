require 'spec_helper'

describe FavoritesController do
  describe "Post 'create'" do
    let(:menu) {Factory(:menu)}
    it "should save favorite if valid" do
      Favorite.count.should == 0
      post :create, format: 'json', menu_id: menu
      Favorite.count.should == 1
      response.body.should == '{}'
    end
  end
end