require 'spec/rake/spectask'
  desc "Verify API specs"
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*.rb']
    t.spec_opts = [ '-cfs' ]
  end
  
