ENV["REDISTOGO_URL"] ||= "redis://redistogo:339d5613e2dfe5a58f4b797a83d454a6@squawfish.redistogo.com:9717/ "

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }