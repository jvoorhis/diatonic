Gem::Specification.new do |s|
  s.name = 'diatonic'
  s.version = '0.1.0'
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeremy Voorhis"]
  s.date = '2009-07-04'
  s.email = 'jvoorhis@gmail.com'
  s.extra_rdoc_files = %w[
    LICENSE
    README.rdoc
  ]
  s.files = %w[
    LICENSE
    README.rdoc
    Rakefile
    lib/diatonic.rb
    lib/diatonic/key.rb
    lib/diatonic/pitch.rb
    lib/diatonic/prelude.rb
    spec/key_spec.rb
    spec/pitch_spec.rb
    spec/spec_helper.rb
  ]
  s.has_rdoc = true
  s.homepage = 'http://github.com/jvoorhis/diatonic'
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = %w[ lib ]
  s.rubygems_version = '1.3.1'
  s.summary = "TODO"
  s.test_files = %w[
    spec/key_spec.rb
    spec/pitch_spec.rb
    spec/spec_helper.rb
  ]
end
