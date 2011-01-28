require 'rubygems'
require 'cucumber'
require 'capybara/cucumber'
require 'webrick'

# Setup capybara for using right driver
Capybara.default_driver = :selenium # or :culerity

# This maps to host for testing, but can be also set via step:
#   Given I am on "http://www.google.pl"
#
Capybara.app_host = 'http://localhost:3000'

Capybara.default_selector = :css

# Extend Cucumber World with minitest assertions
World(MiniTest::Assertions)

class NonCachingFileHandler < WEBrick::HTTPServlet::FileHandler
  def prevent_caching(res)
    res['ETag']          = nil
    res['Last-Modified'] = Time.now + 100**4
    res['Cache-Control'] = 'no-store, no-cache, must-revalidate, post-check=0, pre-check=0'
    res['Pragma']        = 'no-cache'
    res['Expires']       = Time.now - 100**4
  end

  def do_GET(req, res)
    super
    prevent_caching(res)
  end
end

# Launch a webrick server in a thread
AfterConfiguration do
  server_thread = Thread.new do
    server = WEBrick::HTTPServer.new :Port => 3000
    server.mount "/", NonCachingFileHandler , './public'
    trap('INT') { server.stop }
    server.start
  end
  # Kill the server when cucumber is done
  at_exit do
    server_thread.exit
  end
end
