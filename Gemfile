source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :test do
  gem 'json_pure', '<= 2.0.1' if RUBY_VERSION < '2.0.0'
  gem 'metadata-json-lint'
  gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '~> 3.8.0'
  gem 'puppetlabs_spec_helper'
  gem 'rake', '< 11'
  gem 'rspec-core', '>= 3.4'
  gem 'rspec-puppet', :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem 'rspec-puppet-facts'
  gem 'rubocop', '0.42.0'
  gem 'rubocop-rspec', '~> 1.6' if RUBY_VERSION >= '2.3.0'
  gem 'safe_yaml', '~> 1.0.4'
  gem 'simplecov', '>= 0.11.0'
  gem 'simplecov-console'

  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-resource_reference_syntax'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-unquoted_string-check'
  gem 'puppet-lint-version_comparison-check'

  gem 'nokogiri', '1.5.11'
  gem 'parallel_tests'
end

group :development do
  gem 'puppet-blacksmith'
end

group :system_tests do
  gem 'beaker', '2.43.0'
  gem 'beaker-puppet_install_helper'
  gem 'beaker-rspec', '5.3.0'
end
