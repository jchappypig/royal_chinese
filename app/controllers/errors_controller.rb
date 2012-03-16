class ErrorsController < ApplicationController
  def not_found
    render 'errors/404'
  end
end
