require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

namespace :cucumber do
  Cucumber::Rake::Task.new(:ok, 'Run features that should pass') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'default'
  end

  Cucumber::Rake::Task.new(:wip, 'Run features that are being worked on') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'wip'
  end

  Cucumber::Rake::Task.new(:rerun, 'Record failing features and run only them if any exist') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'rerun'
  end

  desc 'Run all features'
  task :all => [:ok, :wip]

  desc "Remove all temp file."
  task :clean do
    system "rm capybara-*.html cucumber.log"
  end
end

desc 'Alias for cucumber:ok'
task :cucumber => 'cucumber:ok'

require "webrick"
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

desc "Run all specs"
task :spec do
  require 'webrick'

  server = WEBrick::HTTPServer.new :Port => 3000
  server.mount "/", NonCachingFileHandler , './public'
  trap('INT') { server.stop }
  require "launchy"
  Launchy.open("http://localhost:3000/spec/spec.html")
  server.start
end

task :default => [:cucumber, :spec]