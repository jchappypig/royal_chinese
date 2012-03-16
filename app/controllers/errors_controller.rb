class ErrorsController < ApplicationController
  def not_found
    render '/404'
  end
end
