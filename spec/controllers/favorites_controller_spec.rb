require 'spec_helper'

describe FavoritesController do
  describe "Post 'create'" do

    let(:menu) {Factory(:menu)}

    it "should save favorite if valid" do
      post :create, format: 'js', menu_id: menu
      response.should render_template :create
    end
  end
end