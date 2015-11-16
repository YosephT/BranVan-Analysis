json.array!(@vehicle_readings) do |vehicle_reading|
  json.extract! vehicle_reading, :id, :reading_id, :agency_id, :call_name, :current_stop_id, :heading, :vehicle_id, :latitude, :longitude, :route_id, :segment_id, :speed, :timestamp
  json.url vehicle_reading_url(vehicle_reading, format: :json)
end
