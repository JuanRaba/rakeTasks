class Engineer < ApplicationRecord
  validates :idorigin, uniqueness: true
  has_many :jobs
  # class method to load
  def self.get_and_store_engineers(api)
    base_json = ApplicationHelper.get_json( api+"/engineers" )
    base_json["engineers"].each do |engineer|
      Engineer.create(
        name: engineer["name"],
        idorigin: engineer["id"],
        url: engineer["do_not_try_this"]
      )
    end
  end

  def self.get_and_store_jobs!(api)
    Job.destroy_all
    Engineer.all.each do |engineer| # make this paralel with Active Jobs
      engineer.get_and_store_jobs(api)
    end
  end

  def self.calculate_and_store_xp
    Engineer.all.each do |engineer| # make this paralel with Active Jobs
      engineer.set_xp
      engineer.save!
    end
  end

  def self.generate_ranking2018csv(destination)
    #######ranking2018.csv###########
    # "ranking", 
    #{ "engineers": 
    #  [ 
    #    { "name": "nombre", "work experience_days": 1234 },
    #    { "name": "nombre", "work experience_days": 1234 }...
    #  ] 
    #}
    engineers_text = ""
    Engineer.all.order(xp: :desc).map do |engineer|
      engineers_text += "{ \"name\": \"#{engineer.name}\", \"work experience_days\": #{engineer.xp} },"
    end
    full_text = "{ \"engineers\": [#{engineers_text}]}"
    full_text_doble_quoted = full_text.gsub('"','""')
    
    csv_text = "\"ranking\", \"#{full_text}\""
    File.open(
      File.join(destination, 'ranking2018.csv'),
      'w'
    ) { |file| file.write(csv_text) }
  end


  def store_jobs(engineer_json)
    engineer_json["jobs"].each do |job|
      Job.create(
          engineer: self,
          employer: job["employer"],
          start_date: job["start_date"],
          end_date: job["end_date"]
        )
    end
  end

  def get_and_store_jobs(api)
    engineer_json = ApplicationHelper.get_json(api+self.url)
    store_jobs(engineer_json)
  end

  def set_xp
    jobs = self.jobs.order(start_date: :asc)
    #initialize variables
    xp = 0
    day0 = "1970-01-01"
    last_date = Date.parse day0
    #config variable 
    max_date_str = "2018-12-31"
    max_date = Date.parse max_date_str

    # ENSURE EMPLOYEMENT DATES AT THIS POINT  
    jobs.each do |job|
      # get data
      start_date = job["start_date"]
      end_date = job["end_date"]

      start_date = max_date if start_date > max_date

      if end_date == nil
        end_date = max_date # Date.today.to_s
      end      
      end_date = max_date if end_date > max_date   

      # EMPLOYEMENT DATE MUST BE ORDERED AT THIS POINT
      if last_date < start_date
        #puts "added xp empl separated"
        xp += (end_date - start_date).to_i
        last_date = end_date
      else
        #puts "emp overlaped"
        start_date = last_date  
        if start_date < end_date
          #puts "added xp as not overlaped with last end"
          xp += (end_date - start_date).to_i
          last_date = end_date
        else
          #puts "skiped xp cause overlaped"
        end
      end
    end
    self.xp = xp
  end
end
