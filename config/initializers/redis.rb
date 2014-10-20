#Redis.current = Redis.new(:host => "127.0.0.1", :port => 6379, :db => 1)
#Redis.current = Redis.new("redis://127.0.0.1:6379/1")
$redis = Redis.new(:host => "127.0.0.1", :port => 6379, :db => 1)
