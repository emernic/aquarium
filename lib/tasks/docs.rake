namespace :docs do

  desc 'Generate publicly accessible documentation'

  md = [
    "Krill",
    "API",
    "Installation",
    "Location Wizard",
    "Folders",
    "Reference",
    "Oyster",
    "DataAssociation"
  ]

  task :md do 
    puts "copying doc/*.md files to public/doc/md"
    sh "rm -rf public/doc/md"    
    sh "mkdir public/doc/md"
    md.each do |name|
      sh "cp 'doc/#{name}.md' public/doc/md"
    end
    sh "cp -r doc/images public/doc"
  end

  # task :auto do
  #   puts "autogenerating operation api docs"
  #   sh "rm -rf public/doc/operation-api"
  #   sh "mkdir public/doc/operation-api"    
  #   sh "cd lib/krill/workflow; yard doc"
  #   sh "mv lib/krill/workflow/doc public/doc/operation-api"
  # end

end
