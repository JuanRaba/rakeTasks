namespace :mytasks do
  desc "sample task"
  task :sample do
    
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
    @base["engineers"].each do |engineer|
      puts engineer.values
    end

    eng1url = @base["engineers"].first["do_not_try_this"] #/engineers/1
    @eng1 = get_json(api+eng1url)
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
    @eng1["jobs"].each do |job|
      puts job["start_date"] + " " job["end_date"]
    end
    puts "wololo"
  end
end

def get_json(url)
  require "net/http"
  url
  #JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
end