class ErrorsController  < ApplicationController
  skip_before_filter :authenticate_user!, only: [:not_found]

  def not_found

  end
end