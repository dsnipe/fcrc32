Gem::Specification.new do |s|
  s.name = "fcrc32"
  s.version = "0.0.1"
  s.homepage = "https://github.com/dsnipe/fcrc32"
  s.authors = ["Dmitry Tymchuk"]
  s.email = ["dsnipe@gmail.com"]
  s.license = "MIT"
  s.summary = "Fast CRC32 algorithm"
  s.description = s.summary

  s.require_path = "lib"
  s.files = []

  s.extensions = Dir["ext/**/extconf.rb"]
  s.files += Dir["ext/**/*.{rb,c,h}"]

  s.files += Dir["lib/**/*.rb"]
  s.files += %w(Rakefile)

  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rake-compiler", "~> 0.9"
  s.add_development_dependency "minitest", "~> 5.5.1"
  s.add_development_dependency "crc32", "~> 1.0"
end
