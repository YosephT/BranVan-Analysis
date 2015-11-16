module StopsHelper
    def findPlace(lat, lon)
    	c = 0.00005
    	static_c = 0.00005
    	found = false
    	locations = Hash.new
    	Stop.all.each do |s|
    	    locations[s.name] = Node.new(s.latitude, s.longitude)
		end
    			
    	while !found
    		x = Node.new(lat, lon)
    		up = Node.new(x.lat+c, x.lon)
    		down = Node.new(x.lat-c, x.lon)
    		left = Node.new(x.lat, x.lon-c)
    		right = Node.new(x.lat, x.lon+c)
    
    		locations.each do |k, v|
    			if v.lat <= up.lat && v.lat >= down.lat && v.lon >= left.lon && v.lon <= right.lon
    				return k
    			end
    		end
    		c += c
    	end
    end
    
    class Node
    	@lat
    	@lon
    
    	def initialize(x, y)
    		@lat = x
    		@lon = y
    	end
    
    	def lat
    		return @lat
    	end
    
    	def lon
    		return @lon
    	end
    end
    
    
    def getSpeeding
        data = Hash.new
        VehicleReading.all.each do |r|
            if r.speed > 35
                location = findPlace(r.latitude, r.longitude)
                if data.has_key?(location)
                    data[location] = (data[location]+r.speed)/2
                else
                    data[location] = r.speed
                end
            end
        end
        return data
    end
    
    def getLateness
        data = Hash.new
        VehicleReading.all.each do |r|
            if r.current_stop_id != nil
                 sto = Stop.where(:stop_id => r.current_stop_id).first
                 if sto != nil
                     if (sto.avgTime - r.timestamp) <= -5
                         if data.has_key?(sto.name)
                            data[sto.name] = (data[sto.name]+(sto.avgTime - r.timestamp).abs)/2
                        else
                            data[sto.name] = (sto.avgTime - r.timestamp).abs
                        end
                    end
                end
            end
        end
        return data
    end
    
    def getDirection(h)
        if h >= 337 && h >= 23
            return "North"
        elsif h > 23 && h < 67
            return "North-East"
        elsif h >= 67 && h <= 113
            return "East"
        elsif h > 113 && h < 157
            return "South-East"
        elsif h >= 157 && h <= 203
            return "South"
        elsif h > 203 && h < 247
            return "South-West"
        elsif h >= 247 && h <= 293
            return "West"
        else 
            return "North-West"
        end
    end
    
    def getStdDev(mean, samples)
        if samples.length == 0 || mean.nil?
            return 0
        end
        squares = Array.new
        samples.each do |s|
            res = (s-mean)*(s-mean)
            squares << res
        end
        total = 0
        squares.each do |s|
            total += s
        end
        return Math.sqrt(total/squares.length)
    end
    
end
