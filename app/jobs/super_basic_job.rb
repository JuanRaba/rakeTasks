class SuperBasicJob
  include Sidekiq::Worker

  def perform(api)
    Engineer.get_and_store_jobs_and_calculate_and_store_xp!(api)
    Engineer.calculate_and_store_xp
  end
end
