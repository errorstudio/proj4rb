require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

task :default => :test

desc "Run the tests"
Rake::TestTask::new do |t|
    t.test_files = FileList['test/test*.rb']
    t.verbose = true
end

desc "Generate the documentation"
Rake::RDocTask::new do |rdoc|
  rdoc.rdoc_dir = 'proj4rb-doc/'
  rdoc.title    = "Proj4rb Documentation"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('src/**/*.c')
end

spec = Gem::Specification::new do |s|
  s.platform = Gem::Platform::RUBY

  s.name = 'proj4rb-mswin32'
  s.version = "0.0.1"
  s.summary = "Simple Ruby bindings for the Proj.4 Carthographic Projection library"
  s.description = <<EOF
Proj4rb is a simple ruby binding for the Proj.4 Carthographic Projection library, that supports conversions between a very large number of geographic coordinate systems.
EOF
  s.author = 'Guilhem Vellut'
  s.email = 'guilhem.vellut@gmail.com'
  s.homepage = "http://thepochisuperstarmegashow.com"
  
  s.requirements << 'none'
  s.require_path = 'lib'
  s.files = FileList["lib/**/*.rb", "lib/**/*.dll","lib/**/*.so","data/*","example/**/*.rb","src/**/*.h","src/**/*.c","test/**/*.rb", "README","MIT-LICENSE","rakefile.rb"]
  s.test_files = FileList['test/test*.rb']

  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.rdoc_options.concat ['--main',  'README']
end

desc "Package the library as a gem"
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
