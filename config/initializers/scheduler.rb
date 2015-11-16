require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

# s.every '10s' do
#     puts "does this fucking work???"
#     Rails.logger.info "hello, it's #{Time.now}"
#     VehicleReading.ourMethod
# end



s.every '15s' do
    # puts "does this fucking work???"
    # Rails.logger.info "hello, it's #{Time.now}"
    VehicleReading.ourMethod
end