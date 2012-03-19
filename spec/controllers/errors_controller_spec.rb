require 'spec_helper'

describe ErrorsController do
  describe "#not_found" do
    it "should render customized 404 page for html format" do
      get 'not_found'
      response.should render_template :not_found
    end

    it "should be able to handle other formats" do
      get 'not_found', format: 'any'
      response.should render_template :not_found
    end
  end
end