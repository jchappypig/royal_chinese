require 'spec_helper'

describe "user CRUD menus", js: true do

  before :each do
    visit menus_path
  end

  it "should allow user create, updated, delete menus." do
    page.should have_content "Listing menus"
    click_link "New Menu"

    page.should have_content "New menu"
    fill_in "menu_name", with: "Cabbage"
    fill_in "menu_category", with: "Vegetable"
    fill_in "menu_price", with: "1.5"
    fill_in "menu_dish_type", with: "Hotpot"
    check "menu_is_vegetarian"
    click_button "Create Menu"
    find(".alert-error").should have_content("Menu was successfully created.")

    click_link "Edit"
    page.should have_content "Editing menu"
    fill_in "menu_price", with: "2"
    click_button "Update Menu"
    find(".alert-error").should have_content("Menu was successfully updated.")

    click_link "Back"
    page.current_path.should == menus_path

    page.should have_content("Cabbage")
    click_link "Destroy"
    page.evaluate_script("window.confirm = function() { return true; }")

  end
end