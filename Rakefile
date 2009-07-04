require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'rake/gempackagetask'

Rake::RDocTask.new do |rd|
  rd.rdoc_files.include("lib/**/*.rb")
end

Spec::Rake::SpecTask.new do |t| end
task :default => :spec

gemspec = eval(File.read('diatonic.gemspec'))
Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
