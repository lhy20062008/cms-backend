Gem::Specification.new do |spec|
  spec.name = 'cms-backend'
  spec.version = '0.0.1'
  spec.required_ruby_version = '>= 2.7.0'
  spec.files =  `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']
  spec.summary = 'CMS Backend'
  spec.author = 'huyang'
  spec.add_dependency "rails",  ">= 6.1.3"
  spec.add_dependency 'rubocop-github'
end
