Gem::Specification.new do |gem|
  gem.name        = "swagger_client"
  gem.version     = "0.0.1"
  gem.author      = "Andrew Kozin"
  gem.email       = "nepalez@evilmartians.com"
  gem.homepage    = "https://github.com/nepalez/swagger_client"
  gem.summary     = "HTTP client initialized by swagger specification"
  gem.license     = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = gem.files.grep(/^spec/)
  gem.extra_rdoc_files = Dir["README.md", "LICENSE", "CHANGELOG.md"]

  gem.required_ruby_version = ">= 2.2"

  gem.add_runtime_dependency "dry-initializer", "~> 0.4.0"
  gem.add_runtime_dependency "dry-pipeline", "~> 0.0.2"
  gem.add_runtime_dependency "dry-types", "~> 0.8.1"
  gem.add_runtime_dependency "dry-validation", "~> 0.9.2"

  gem.add_development_dependency "bundler", "~> 1.12"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "guard-rspec", "~> 4.0"
  gem.add_development_dependency "webmock", "~> 1.22"
end
