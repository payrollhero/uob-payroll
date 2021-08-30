# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uob/payroll/version'

Gem::Specification.new do |spec|
  spec.name          = "uob-payroll"
  spec.version       = Uob::Payroll::VERSION
  spec.authors       = ["Vincent Paca"]
  spec.email         = ["vpaca@payrollhero.com"]

  spec.summary       = %q{A UOB Payroll File Generator}
  spec.description   = %q{A UOB Payroll File Generator}
  spec.homepage      = "https://github.com/payrollhero/uob-payroll"
  spec.license       = 'BSD-3-Clause'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "> 1.16", "< 3"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry'
  if RUBY_VERSION < "2.3"
    spec.add_development_dependency 'github_changelog_generator', '< 1.15'
  else
    spec.add_development_dependency 'github_changelog_generator'
  end

  spec.add_dependency 'activesupport'
  spec.add_dependency 'activemodel'
  spec.add_dependency 'ph_model'
end
