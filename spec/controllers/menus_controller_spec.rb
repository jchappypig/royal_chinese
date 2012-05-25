require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/priority_control'


describe MenusController do
  include PriorityControl

  context "not authenticated user" do
    it "should not allow user access'" do
      get :index
      should_deny_access

      get :new
      should_deny_access

      post :create, menu: Factory.attributes_for(:menu)
      should_deny_access

      get :edit, id: Factory(:menu)
      should_deny_access

      menu = Factory(:menu)
      put :update, id: menu, menu: menu.attributes.merge(name: "new name")
      should_deny_access

      delete :destroy, id: menu
      should_deny_access

      get :search
      should_deny_access
    end

    describe "GET 'show'" do
      before :each do
        @menu = Factory(:menu)
        get :show, id: @menu
      end

      specify { response.should be_success }
      specify { assigns(:menu) == @menu }
    end
  end

  context "authenticated user" do
    before :each do
      user = Factory(:user)
      sign_in :user, user
    end

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
        post :create, menu: Factory.build(:menu, name: '').attributes
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

    describe "GET 'search'" do
      it "should search menus" do
        page = '1'
        query = 'Fish'

        search_collections = mock
        search_results = mock
        search_collections.should_receive(:results).and_return(search_results)
        Search::MenuSearch.should_receive(:execute).with(query, page).and_return(search_collections)

        get :execute, page: page, query: query

        assigns(:menus).should == search_results
      end
    end
  end
end
