namespace :mytasks do
  desc "sample task"
  task :sample => :environment do
    
    api = "https://demo0644754.mockable.io"  
    #@base = get_json( api+"/engineers" )
    @base = {
      "engineers"=>[
        {"id"=>1, "name"=>"Chris Bosh", "do_not_try_this"=>"/engineers/1"},
        {"id"=>2, "name"=>"Jack Dorsey", "do_not_try_this"=>"/engineers/2"},
        {"id"=>3, "name"=>"Bill Gates", "do_not_try_this"=>"/engineers/3"},
        {"id"=>4, "name"=>"Drew Houston", "do_not_try_this"=>"/engineers/4"},
        {"id"=>5, "name"=>"Gabe Newell", "do_not_try_this"=>"/engineers/5"},
        {"id"=>6, "name"=>"Ruchi Sanghvi", "do_not_try_this"=>"/engineers/6"},
        {"id"=>7, "name"=>"Mark Zuckerberg", "do_not_try_this"=>"/engineers/7"},
        {"id"=>8, "name"=>"Linus Torvalds", "do_not_try_this"=>"/engineers/8"},
        {"id"=>9, "name"=>"Larry Page", "do_not_try_this"=>"/engineers/9"}
      ]
    }
    print @base["engineers"].first.keys #["id", "name", "do_not_try_this"]
    puts ''

    store_engineers(@base)
    #gtask_store_jobs_for_DBengineers!(api)
    gtask_calculatexp_for_DBengineers_fromDBjobs
    show_success

    puts ''
    puts "wololo"
  end
end

def show_success
  Engineer.all.each do |engineer| # make this paralel with Active Jobs
    puts "#{engineer.id} #{engineer.name} #{engineer.idorigin} #{engineer.xp}"
  end
end

def gtask_calculatexp_for_DBengineers_fromDBjobs
  Engineer.all.each do |engineer| # make this paralel with Active Jobs
    engineer.xp = calc_xp_for_DBengineer(engineer)
    engineer.save!
  end
end

def calc_xp_for_DBengineer(engineer)
  calc_xp_fromDBjobs(engineer.jobs) # ENSURE JOBS ordered by start_date
end

def calc_xp_fromDBjobs(jobs)
  #DB gives date formated start and end values
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
  xp
end

def gtask_store_jobs_for_DBengineers!(api)
  Job.destroy_all
  Engineer.all.each do |engineer| # make this paralel with Active Jobs
    engineer_json = get_json(api+engineer["url"])
    store_jobs(engineer_json)
    puts "name: #{engineer.name} jobscount: #{engineer.jobs.count}"
  end
end

def store_jobs(engineer_json)
  engineer = Engineer.find_by(idorigin:engineer_json["id"])
  engineer_json["jobs"].each do |job|
    Job.create(
        engineer: engineer,
        employer: job["employer"],
        start_date: job["start_date"],
        end_date: job["end_date"]
      )
  end
end
def store_engineers(base)
  base["engineers"].each do |engineer|
    Engineer.create(
      name: engineer["name"],
      idorigin: engineer["id"],
      url: engineer["do_not_try_this"]
    )
  end
end

def rock
  puts "get ready to ROCK"
  puts "get ready to ROCK"
  puts "get ready to ROCK"
  puts ''
  @base["engineers"].each do |engineer|
    engUrl = engineer["do_not_try_this"]
    @eng = get_json(api+engUrl)
    puts @eng
    print calc_xp(@eng)
    puts ''
  end
end

def test_calc_xp(base)
  eng1url = base["engineers"].first["do_not_try_this"] #/engineers/1
  #@eng1 = get_json(api+eng1url)
  @eng1 = {
    "id"=>1,
    "name"=>"Chris Bosh",
    "jobs"=>[
      {"employer"=>"emp1", "start_date"=>"1990-02-22", "end_date"=>"1991-01-09"},
      {"employer"=>"emp2", "start_date"=>"1990-10-02", "end_date"=>"1995-04-04"},
      {"employer"=>"emp3", "start_date"=>"2000-03-18", "end_date"=>"2002-07-12"},
      {"employer"=>"emp4", "start_date"=>"2000-03-19", "end_date"=>"2002-07-13"},
      {"employer"=>"emp5", "start_date"=>"2009-05-01", "end_date"=>nil}
    ]
  }
  print @eng1["jobs"].first.keys # ["employer", "start_date", "end_date"]
  puts '' 
  print calc_xp(@eng1)
  puts ''
end

# Calcs xp of an engineer with employement date ordered
def calc_xp(eng)
  #initialize variables
  xp = 0
  day0 = "1970-01-01"
  last_date = Date.parse day0
  #config variable 
  max_date_str = "2018-12-31"
  max_date = Date.parse max_date_str

  # ENSURE EMPLOYEMENT DATES AT THIS POINT  
  eng["jobs"].each do |job|
    # get data
    start_date = job["start_date"]
    end_date = job["end_date"]

    # convert nil end and parse dates
    start_date = Date.parse start_date
    start_date = max_date if start_date > max_date

    if end_date == nil
      end_date = max_date_str # Date.today.to_s
    end      
    end_date = Date.parse end_date 
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
  [eng["id"],eng["name"],xp]
end

def get_json(url)
  require "net/http"
  url
  sleep 16
  JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
end
