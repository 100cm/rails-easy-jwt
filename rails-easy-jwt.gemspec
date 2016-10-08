# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'icepoint/oauth/filter/version'
require 'jwt'
Gem::Specification.new do |spec|
  spec.name          = "atyun-oauth-filter"
  spec.version       = Atyun::Oauth::Filter::VERSION
  spec.authors       = ["icepoint0"]
  spec.email         = ["351711778@qq.com"]

  spec.summary       = "王珏"
  spec.description   = "简单的jwt过滤器"
  spec.homepage      = "git@github.com:icepoint0/rails-easy-jwt.git"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'jwt'
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
