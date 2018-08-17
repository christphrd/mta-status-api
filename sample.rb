require 'protobuf'
require 'google/transit/gtfs-realtime.pb'
require 'net/http'
require 'uri'

require 'pry'
API_KEY = 

data = Net::HTTP.get(URI.parse("http://datamine.mta.info/mta_esi.php?key=#{API_KEY}&feed_id=1"))
feed = Transit_realtime::FeedMessage.decode(data)
for entity in feed.entity do
  if entity.field?(:trip_update)
    p entity.trip_update
    binding.pry
  end
end