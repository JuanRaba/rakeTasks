namespace :mytasks do
  desc "sample task"
  task :sample, [:api] => :environment do |task, args|
    api = "https://demo0644754.mockable.io"
    api = args[:api] if args[:api] != nil
    Engineer.get_and_store_engineers(api)
    Engineer.get_and_store_jobs_and_calculate_and_store_xp!(api)
    Engineer.generate_ranking2018csv(Rails.root) # nosotros dejemos el ranking en su ftp)
    puts "ranking2018csv generated in Rails.root"
  end

  task :jobrunner, [:api] => :environment do |task, args|
    api = "https://demo0644754.mockable.io"
    api = args[:api] if args[:api] != nil
    CreatorJob.new.perform(api)
    puts "Launched"
  end
end
