# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :minitest do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$}) do |m|
    "test/#{m[1]}test_#{m[2]}.rb"
  end
  watch(%r{^test/test_helper\.rb$}) do
    'test'
  end

  # Rails 4
  watch(%r{^app/(.+)\.rb$}) do |m|
    "test/#{m[1]}_test.rb"
  end
  watch(%r{^app/controllers/application_controller\.rb$}) do
    'test/controllers'
  end
  watch(%r{^app/controllers/(.+)_controller\.rb$}) do |m|
    "test/integration/#{m[1]}_test.rb"
  end
  watch(%r{^app/views/(.+)_mailer/.+}) do |m|
    "test/mailers/#{m[1]}_mailer_test.rb"
  end
  watch(%r{^lib/(.+)\.rb$}) do |m|
    "test/lib/#{m[1]}_test.rb"
  end
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) do
    'test'
  end
end
