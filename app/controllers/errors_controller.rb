class ErrorsController  < ApplicationController
  skip_before_filter :authenticate_user!, only: [:not_found, :internal_server_error, :unprocessable_entity_error]

  def not_found
  end

  def internal_server_error
  end

  def unprocessable_entity_error
  end
end