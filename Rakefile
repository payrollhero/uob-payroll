require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

desc "Updates the changelog"
task :changelog do
  sh "github_changelog_generator payrollhero/aub-payroll"
end
