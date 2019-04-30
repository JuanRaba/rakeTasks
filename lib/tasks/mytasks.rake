namespace :mytasks do
  desc "sample task"
  task :sample => :environment do
    api = "https://demo0644754.mockable.io"  
    Engineer.get_and_store_engineers(api)
    Engineer.get_and_store_jobs_and_calculate_and_store_xp!(api)
    Engineer.generate_ranking2018csv(Rails.root) # nosotros dejemos el ranking en su ftp)
    puts "ranking2018csv generated in Rails.root"
  end

  task :jobrunner => :environment do
    CreatorJob.new.perform
    puts "Launched"
  end
end
