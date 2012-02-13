# This part of code is to get rid of the annoying print out on console.
# eg. Started GET "/assets/bootstrap.js?body=1" for 127.0.0.1 at 2012-02-13 23:43:48 +1100

Rails::Rack::Logger.class_eval do
  def call_with_quiet_assets(env)
    previous_level = Rails.logger.level
    Rails.logger.level = Logger::ERROR if env['PATH_INFO'].index("/assets/") == 0
    call_without_quiet_assets(env).tap do
      Rails.logger.level = previous_level
    end
  end
  alias_method_chain :call, :quiet_assets
end