require 'rake/rdoctask'
require 'spec/rake/spectask'

Rake::RDocTask.new do |rd|
  rd.rdoc_files.include("lib/**/*.rb")
end

Spec::Rake::SpecTask.new do |t| end
task :default => :spec
