require 'spec_helper'

describe "customer subscribe newsletters", type: :request do
  before :each do
    visit root_path
  end

  it "should be able to subscribe newsletters" do
    #subscribe first time
    fill_in 'follower_name', with: 'Huanhuan'
    fill_in 'follower_email', with: 'jchappypig@hotmail.com'
    click_on 'Subscribe'
    find('.alert-success').should have_content('You have successfully subscribed to our newsletter.')
    page.current_path.should == root_path

    #subscribe second time with the same email address
    fill_in 'follower_name', with: 'Yoki'
    fill_in 'follower_email', with: 'jchappypig@hotmail.com'
    click_on 'Subscribe'
    find('.alert-success').should have_content('You have successfully subscribed to our newsletter.')
    page.current_path.should == root_path

    #subscribe with a different email address
    fill_in 'follower_name', with: 'Happy pig'
    fill_in 'follower_email', with: 'hhuang@thoughtworks.com'
    click_on 'Subscribe'
    find('.alert-success').should have_content('You have successfully subscribed to our newsletter.')
    page.current_path.should == root_path

  end
end