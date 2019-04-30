class SuperBasicJob
  include Sidekiq::Worker

  def perform(api)
    Engineer.get_and_store_engineers(api)
    Engineer.get_and_store_jobs!(api)
    Engineer.calculate_and_store_xp
  end
end
