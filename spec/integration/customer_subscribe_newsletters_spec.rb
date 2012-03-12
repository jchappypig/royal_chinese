require 'spec_helper'

describe "customer subscribe newsletters", type: :request do
  include EmailSpec::Helpers

  before :each do
    visit root_path
  end

  it "should be able to subscribe newsletters" do
    fill_in 'follower_name', with: 'Huanhuan'
    fill_in 'follower_email', with: 'jchappypig@hotmail.com'
    click_on 'Subscribe'
    find('.alert-success').should have_content('You have successfully subscribed to our newsletter.')
    page.current_path.should == root_path

    open_last_email
    visit_in_email('click here')

    page.current_url.should ==  unsubscribing_followers_url
    fill_in 'follower_email', with: 'jchappypig@hotmail.com'
    click_on 'Unsubscribe'

    find('.alert-success').should have_content('You have successfully unsubscribed to our newsletter.')
    page.current_path.should == root_path
  end
end