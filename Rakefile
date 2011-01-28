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

task :default => :cucumber