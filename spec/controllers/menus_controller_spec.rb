require 'spec_helper'

describe MenusController do
  describe "GET 'index'" do
    before :each do
      Factory(:menu)
      get :index
    end

    specify { response.should be_success }
    specify { assigns(:menus).count.should == 1 }
  end

  describe "GET 'new'" do
    before :each do
      get :new
    end

    specify { response.should be_success }
    specify { assigns(:menu).should be_kind_of(Menu) }
  end

  describe "GET 'show'" do
    before :each do
      @menu = Factory(:menu)
      get :show, id: @menu
    end

    specify { response.should be_success }
    specify { assigns(:menu) == @menu }
  end

  describe "Post 'create'" do
    it "should save menu if valid" do
      Menu.count.should == 0
      post :create, menu: Factory.build(:menu).attributes
      Menu.count.should == 1

      flash[:notice].should == 'Menu was successfully created.'
      response.should redirect_to menu_path(assigns(:menu))
    end

    it "should not save menu if invalid" do
      Menu.count.should == 0
      post :create, menu: Factory.build(:menu, name: "").attributes
      Menu.count.should == 0

      response.should render_template :new
    end
  end

  describe "GET 'edit'" do
    before :each do
      @menu = Factory(:menu)
      get :edit, id: @menu
    end

    specify { response.should be_success }
    specify { assigns(:menu).should == @menu }
  end

  describe "Put 'update'" do
    before :each do
      @menu = Factory(:menu)
    end

    it "should update menu if valid" do
      put :update, id: @menu, menu: @menu.attributes.merge(name: "new name")

      Menu.find_by_id(@menu).name.should == "new name"

      flash[:notice].should == 'Menu was successfully updated.'
      response.should redirect_to menu_path(assigns(:menu))
    end

    it "should not update menu if invalid" do
      put :update, id: @menu, menu: @menu.attributes.merge(name: "")

      Menu.find_by_id(@menu).name.should == @menu.name

      response.should render_template :edit
    end
  end

  describe "Delete 'destroy'" do
    it "should destroy menu" do
      menu = Factory(:menu)
      Menu.count.should == 1
      delete :destroy, id: menu
      Menu.count.should == 0

      response.should redirect_to menus_path
    end
  end
end
