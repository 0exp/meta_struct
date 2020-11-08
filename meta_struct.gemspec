# frozen_string_literal: true

require_relative 'lib/meta_struct/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7')

  spec.name    = 'meta_struct'
  spec.version = MetaStruct::VERSION
  spec.authors = ['Rustam Ibragimov']
  spec.email   = ['iamdaiver@gmail.com']

  spec.summary     = 'Commonly used data structures realized in scope of Ruby'
  spec.description = 'Commonly used data structures realized in scope of Ruby'
  spec.homepage    = 'https://github.com/0exp/meta_struct'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] =
    spec.homepage
  spec.metadata['source_code_uri'] =
    'https://github.com/0exp/meta_struct'
  spec.metadata['changelog_uri'] =
    'https://github.com/0exp/meta_struct/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'smart_container', '~> 0.8.0'
  spec.add_runtime_dependency 'smart_injection', '~> 0.1.0'

  spec.add_development_dependency 'bundler',          '~> 2.1'
  spec.add_development_dependency 'rake',             '~> 13.0'
  spec.add_development_dependency 'rspec',            '~> 3.9'
  spec.add_development_dependency 'armitage-rubocop', '~> 1.2.0'
  spec.add_development_dependency 'simplecov',        '~> 0.19'
  spec.add_development_dependency 'pry',              '~> 0.13'
end
