require 'spec_helper'

describe MenusController do
  before :each do
    @menu = Factory(:menu)
  end

  it "should get index" do
    get :index
    response.should be_success
    assigns(:menus).should_not be_nil
  end

  it "should get new" do
    get :new
    response.should be_success
  end

  it "should create menu" do
    Menu.count.should == 1
    post :create, menu: @menu.attributes
    Menu.count.should == 2

    response.should redirect_to menu_path(assigns(:menu))
  end

  it "should show menu" do
    get :show, id: @menu
    response.should be_success
  end

  it "should get edit" do
    get :edit, id: @menu
    response.should be_success
  end

  it "should update menu" do
    put :update, id: @menu, menu: @menu.attributes
    response.should redirect_to menu_path(assigns(:menu))
  end
  #
  it "should destroy menu" do
    Menu.count.should == 1
    delete :destroy, id: @menu
    Menu.count.should == 0

    response.should redirect_to menus_path
  end
end
