class ErrorsController < ApplicationController
  ERRORS = [
      :internal_server_error,
      :not_found,
      :unprocessable_entity
  ].freeze

  ERRORS.each do |error|
    define_method error do
      respond_to do |format|
        format.html { render error }
        format.any { head error }
      end
    end
    end
end