require 'rake/testtask'
require './lib/app.rb'

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

desc "Migrate database."
task :migrate do
  Page.new.teardown_pages
end
