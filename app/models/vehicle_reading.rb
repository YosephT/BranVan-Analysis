class VehicleReading < ActiveRecord::Base
    
    def self.timingTest
        response = Unirest.get "http://feeds.transloc.com/3/vehicle_statuses.json?agencies=483",
        headers:{
          "X-Mashape-Key" => "7hQN9cDZFlmshHcpbDaNSJnlIYvxp1KOTEajsn7icTHqdT2M6x",
          "Accept" => "application/json"
        }
        # if (response.body["success"] == true) {
            File.open("Sample4.txt", "a") { |f| f.puts(response.body["vehicles"])}
        # }
        # File.open("Sample.txt", "a") { |f| f.puts("test") }
    end
    
    def self.ourMethod
        puts "****"
        puts "Start call to Transloc API"
        @vehicle_readings = VehicleReading.all
        response = Unirest.get "http://feeds.transloc.com/3/vehicle_statuses.json?agencies=483",
        headers:{
          "X-Mashape-Key" => "7hQN9cDZFlmshHcpbDaNSJnlIYvxp1KOTEajsn7icTHqdT2M6x",
          "Accept" => "application/json"
        }
        File.open("test11162015.txt", "a") { |f| f.puts(response.body["vehicles"])}
        response.body["vehicles"].each do |element|
            r_id = nil
            c_s_id = nil
            head = nil
            v_id = nil
            lat = nil
            longit = nil
            sp = nil
            ts = nil
            if element["call_name"] == "56"
                element.keys.each_with_index do |key, index|
                    if key == "id"
                        v_id = element["id"]
                    elsif key == "current_stop_id"
                       c_s_id = element["current_stop_id"]
                    elsif key == "heading"
                       head = element["heading"]
                    elsif key == "position"
                      lat =element["position"][0]
                      longit = element["position"][1]
                    elsif key == "speed"
                      sp = element["speed"]
                    elsif key == "timestamp"
                       ts = element["timestamp"]/1000
                       ts = Time.at(ts).min
                       if ts > 30
                           ts = ts-30
                       end
                    end
                end 
                if c_s_id != nil 
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

        puts "End Call"
        puts "****"
    end 
    
    
    def self.parse_our_json
        require 'json'
        	r_id = nil
        	c_s_id = nil
        	head = nil
        	v_id = nil
        	lat = nil
        	longit = nil
        	sp = nil
        	ts = nil
        File.foreach('outputFixed.json') do |line|
        	parsed = JSON.parse(line)
        	if (parsed["call_name"] == "52" || parsed["call_name"] == "56")
        # 		puts parsed["id"]
        		parsed.keys.each_with_index do |key, index|
        			if key == "id"
        				v_id = parsed["id"].to_i
        			elsif key == "current_stop_id"
        				c_s_id = parsed["current_stop_id"].to_i
        			elsif key == "heading"
        				head = parsed["heading"].to_i
        			elsif key == "position"
        				lat = parsed["position"][0].to_f
        				longit = parsed["position"][1].to_f
        			elsif key == "speed"
        				sp = parsed["speed"].to_i
        			elsif key == "timestamp"
        				ts = parsed["timestamp"]/1000
        				ts = Time.at(ts).min
        				if ts > 30
        					ts = ts-30
        				end
        			end
        		end
        		
        		if (c_s_id != nil) 
            		if Stop.where(:stop_id => c_s_id).first != nil
            			minute = ts
            			current_stop = Stop.where(:stop_id => c_s_id).first
            			if current_stop.avgTime != nil
            				atime = (current_stop.avgTime+minute)/2
            				current_stop.update(avgTime: atime)
            			else
            				current_stop.update(avgTime: minute)
            			end
            		else
            # 			puts "No Record"
            		end
        	    end
        		
        	end
        	if (sp.is_a? Integer)
        	    vehicle = VehicleReading.create(current_stop_id: c_s_id, heading: head, vehicle_id: v_id, latitude: lat, longitude: longit, speed: sp, timestamp: ts)
        	end
        end
    end
end
