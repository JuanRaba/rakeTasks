module ApplicationHelper
  def self.get_json(url)
    require "net/http"
    # FIX with ACTIVE JOBS
    15.times do |v|
      print "#{v+1}."
      sleep 1
    end
    JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
  end

end
