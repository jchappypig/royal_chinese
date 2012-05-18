require 'spec_helper'
require File.dirname(__FILE__) + '/helpers/priority_control'

describe HomeController do
  include PriorityControl

  context "not authenticated user" do
    describe "GET 'our menu'" do
      before :each do
        dish_type_one = Menu::DISH_TYPES.first
        dish_type_two = Menu::DISH_TYPES.last
        @dish_type_one_menu_1 = Factory(:menu, dish_type: dish_type_one)
        @dish_type_one_menu_2 = Factory(:menu, dish_type: dish_type_one)
        @dish_type_two_menu_1 = Factory(:menu, dish_type: dish_type_two)
        @dish_type_two_menu_2 = Factory(:menu, dish_type: dish_type_two)
      end

      context "no dish type is specified" do
        it "should get menu from the first available dish type" do
          get :our_menu

          assigns(:menus).should include @dish_type_one_menu_1, @dish_type_one_menu_2
          assigns(:menus).should_not include @dish_type_two_menu_1, @dish_type_two_menu_2

          response.should be_success
        end
      end

      context "dish type is specified" do
        it "should get menus from specified dish type" do
          get :our_menu, dish_type: @dish_type_two_menu_1.dish_type

          assigns(:menus).should_not include @dish_type_one_menu_1, @dish_type_one_menu_2
          assigns(:menus).should include @dish_type_two_menu_1, @dish_type_two_menu_2
        end
      end

    end

    describe "GET :our location" do
      before :each do
        get :our_location
      end

      specify { response.should be_success }
    end

    describe "GET :admin" do
      specify {get :admin; should_deny_access}
    end
  end

  context "authenticated user" do
    before :each do
      user = Factory(:user)
      sign_in :user, user
    end

    describe "GET :admin" do
      specify {get :admin; response.should render_template :admin}
    end
  end
end
