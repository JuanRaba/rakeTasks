namespace :mytasks do
  desc "sample task"
  task :sample do
    require "net/http"
    url = "https://demo0644754.mockable.io/engineers"  
    @json = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
    puts @json
  end
end
