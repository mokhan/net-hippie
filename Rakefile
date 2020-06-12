# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.verbose = true
  t.test_files = FileList['test/**/*_test.rb']
end
RuboCop::RakeTask.new(:rubocop)

task lint: [:rubocop]
task default: :test
