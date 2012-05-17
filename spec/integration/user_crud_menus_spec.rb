require 'spec_helper'

include Warden::Test::Helpers

describe "user CRUD menus" do
  before :each do
    Warden.test_mode!
    user = Factory(:user)
    login_as(user, scope: :user)
  end

  it "should allow user create, updated, delete menus." do
    visit menus_path
    page.should have_content 'Listing menus'
    page.should have_content 'Sorry, no menus found.'
    page.should_not have_selector('table#menus')
    click_link 'New Menu'

    page.should have_content 'New menu'
    fill_in 'menu_name', with: 'Cabbage'
    select 'Vegetable', from: 'menu_category'
    fill_in 'menu_price', with: '1.5'
    select 'Hotpot', from: 'menu_dish_type'
    check 'menu_is_vegetarian'
    click_button 'Create Menu'
    find('.alert-success').should have_content('Menu was successfully created.')

    page.should have_content 'Cabbage'
    page.should have_content 'Vegetable'
    page.should have_content '1.5'
    page.should have_content 'Hotpot'
    page.should have_content true

    click_link 'Edit'
    page.should have_content 'Editing menu'
    fill_in 'menu_price', with: '2'
    click_button 'Update Menu'
    find('.alert-success').should have_content('Menu was successfully updated.')

    page.should have_content '2'

    click_link 'Back'
    page.current_path.should == menus_path
    page.should have_selector('table#menus')

    page.should have_content('Cabbage')
    click_link 'Destroy'
  end

  after :each do
    Warden.test_reset!
  end
end