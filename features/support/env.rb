require 'rubygems'
require 'cucumber'
require 'capybara/cucumber'
require 'webrick'

# setup capybara on selenium
Capybara.default_driver = :selenium # or :culerity
# This maps to webrick below
Capybara.app_host = 'http://127.0.0.1:3000'
Capybara.default_selector = :css

# Extend Cucumber's World with minitest assertions
World(MiniTest::Assertions)

# Launch a webrick server in a thread
AfterConfiguration do
  server_thread = Thread.new do
    project_root = File.join(File.dirname(__FILE__), '..', '..')
    WEBrick::HTTPServer.new(
      :Port => 3000,
      # TODO use the real application directory
      # Using the prototype directory for now
      :DocumentRoot => File.join(project_root, 'public'),
      :Logger => WEBrick::Log.new(File.join(project_root, 'cucumber.log')),
      :AccessLog => StringIO.new # to nowhere
    ).start
  end
  # Kill the server when cucumber is done
  at_exit do
    server_thread.exit
  end
end
