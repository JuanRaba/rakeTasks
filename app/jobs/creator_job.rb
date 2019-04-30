class CreatorJob
  def perform(api)
    batch = Sidekiq::Batch.new
    batch.description = "Creating"
    batch.on(:success, CreatorJob::Created, {'wololo' => 2})
    batch.jobs do
      SuperBasicJob.perform_async(api)
    end
    puts "jobs launched"
  end
  
  class Created
    def on_success(status, options)
      Engineer.generate_ranking2018csv(Rails.root) # nosotros dejemos el ranking en su ftp)
      puts "ranking2018csv generated in Rails.root"
    end
  end
  
end