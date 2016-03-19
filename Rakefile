# -*- ruby -*-
require 'rake/extensiontask'
require 'rake/testtask'

spec = Gem::Specification.load('fcrc32.gemspec')
Rake::ExtensionTask.new('fcrc32') do |ext|
  ext.lib_dir = "lib/fcrc32"
  ext.gem_spec = spec
end

Rake::TestTask.new(:test) do |t|
  t.libs << %w(lib test)
  t.pattern = "test/**/*_test.rb"
end
Rake::Task[:test].prerequisites << :compile <<  "test:dummy"
task :default => [:test]

desc "Benchmark"
task :bench => [:compile, "test:dummy"] do
  require "./test/fcrc32_bench"
  FCrc32Bench.start
end

namespace :test do
  desc "Create dummy file for tests (SIZE is set a file size, default is 5Mb)"
  task :dummy do
    require 'securerandom'
    ONE_MB = 2 ** 20
    SIZE   = ENV["SIZE"] || 5
    file   = "./test/fixtures/dummy_#{SIZE}.txt"

    next if File.exist?(file)

    File.open(file, 'wb') do |f|
      SIZE.to_i.times { f.write(SecureRandom.random_bytes(ONE_MB)) }
    end
    puts "File with path: `#{file}` created."
  end
end

