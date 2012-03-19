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

  specify { get 'internal_server_error';  response.should render_template :internal_server_error}
  specify { get 'unprocessable_entity_error';  response.should render_template :unprocessable_entity_error}
end