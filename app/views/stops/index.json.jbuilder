json.array!(@stops) do |stop|
  json.extract! stop, :id, :stop_id, :name, :latitude, :longitude
  json.url stop_url(stop, format: :json)
end
