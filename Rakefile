require 'rake/testtask'
require 'bundler'
Bundler::GemHelper.install_tasks


Rake::TestTask.new do |t|
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
end
