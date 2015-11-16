module ApplicationHelper
    
    def self.parse_our_json
        require 'json'
        counter = 0
    
        File.foreach('SeedFile.json') do |line|
        
        	r_id = nil
        	c_s_id = nil
        	head = nil
        	v_id = nil
        	lat = nil
        	longit = nil
        	sp = nil
        	ts = nil
        	parsed = JSON.parse(line)
        	if (parsed["call_name"]== "52")
        		puts parsed["id"]
        		parsed.keys.each_with_index do |key, index|
        			if key == "id"
        				v_id = parsed["id"]
        			elsif key == "current_stop_id"
        				c_s_id = parsed["current_stop_id"]
        			elsif key == "heading"
        				head = parsed["heading"]
        			elsif key == "position"
        				lat =parsed["position"][0]
        				longit = parsed["position"][1]
        			elsif key == "speed"
        				sp = parsed["speed"]
        			elsif key == "timestamp"
        				ts = parsed["timestamp"]/1000
        				ts = Time.at(ts).min
        				if ts > 30
        					ts = ts-30
        				end
        			end
        		end
        	end
        
        	if (c_s_id != nil) 
        		if Stop.where(:stop_id => c_s_id).first != nil
        			minute = ts
        			current_stop = Stop.where(:stop_id => c_s_id).first
        			if current_stop.avgTime != nil
        				puts current_stop.avgTime
        				puts minute
        				atime = (current_stop.avgTime+minute)/2
        				current_stop.update(avgTime: atime)
        				puts "The Current ATIME is"
        				puts atime
        			else
        				current_stop.update(avgTime: minute)
        			end
        		else
        			puts "No Record"
        		end
        	end
        	
        	vehicle = VehicleReading.create(current_stop_id: c_s_id, heading: head, vehicle_id: v_id, latitude: lat, longitude: longit, speed: sp, timestamp: ts)
        end
    end

    
    
    
    
end
