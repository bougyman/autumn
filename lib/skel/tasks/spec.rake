# Speccing tasks
desc "Verify leaf and shared specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb', 'leaves/*/spec/**/*.rb']
  t.spec_opts = [ '-cfs' ]
end

namespace :spec do
  desc "Verify leaf specs"
  Spec::Rake::SpecTask.new('leaves') do |t|
    t.spec_files = FileList['leaves/*/spec/**/*.rb']
    t.spec_opts = [ '-cfs' ]
  end
end


