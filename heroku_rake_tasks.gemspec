# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heroku_rake_tasks/version'

Gem::Specification.new do |spec|
  spec.name          = "heroku_rake_tasks"
  spec.version       = HerokuRakeTasks::VERSION
  spec.authors       = ["Ben Colon"]
  spec.email         = ["ben@colon.com.fr"]
  spec.summary       = %q{Rake tasks to manage an Heroku Application}
  spec.description   = %q{Rake tasks to manage an Heroku Application (Deploy tasks, DB tasks, ...)}
  spec.homepage      = "https://github.com/bencolon/heroku_rake_tasks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
