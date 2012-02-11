# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
end

guard 'rspec', :version => 2, :all_after_pass => false, :cli => '--drb' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/integration"] }
  watch (%r{^app/models/(.+)\.rb$})                   { |m| "spec/models/#{m[1]}_spec.rb" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/integration" }
end
