class BasicJob
  include Sidekiq::Worker

  def perform(api,id)
    engineer = Engineer.find_by_id(id)
    #engineer.get_and_store_jobs(api)
    5.times do |v|
      print "#{id}-#{v+1}."
      sleep 1
    end
    engineer.set_xp
    engineer.save!
  end
end


      #Job.destroy_all
      #Engineer.all.each_with_index do |engineer,index|
      #  id = engineer.id
      #  puts "######{id}-#{index}###"
      #  BasicJob.set(wait: (index*15).seconds).perform_async(api, id)
      #end