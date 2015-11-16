require 'test_helper'

class VehicleReadingsControllerTest < ActionController::TestCase
  setup do
    @vehicle_reading = vehicle_readings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicle_readings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle_reading" do
    assert_difference('VehicleReading.count') do
      post :create, vehicle_reading: { agency_id: @vehicle_reading.agency_id, call_name: @vehicle_reading.call_name, current_stop_id: @vehicle_reading.current_stop_id, heading: @vehicle_reading.heading, latitude: @vehicle_reading.latitude, longitude: @vehicle_reading.longitude, reading_id: @vehicle_reading.reading_id, route_id: @vehicle_reading.route_id, segment_id: @vehicle_reading.segment_id, speed: @vehicle_reading.speed, timestamp: @vehicle_reading.timestamp, vehicle_id: @vehicle_reading.vehicle_id }
    end

    assert_redirected_to vehicle_reading_path(assigns(:vehicle_reading))
  end

  test "should show vehicle_reading" do
    get :show, id: @vehicle_reading
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle_reading
    assert_response :success
  end

  test "should update vehicle_reading" do
    patch :update, id: @vehicle_reading, vehicle_reading: { agency_id: @vehicle_reading.agency_id, call_name: @vehicle_reading.call_name, current_stop_id: @vehicle_reading.current_stop_id, heading: @vehicle_reading.heading, latitude: @vehicle_reading.latitude, longitude: @vehicle_reading.longitude, reading_id: @vehicle_reading.reading_id, route_id: @vehicle_reading.route_id, segment_id: @vehicle_reading.segment_id, speed: @vehicle_reading.speed, timestamp: @vehicle_reading.timestamp, vehicle_id: @vehicle_reading.vehicle_id }
    assert_redirected_to vehicle_reading_path(assigns(:vehicle_reading))
  end

  test "should destroy vehicle_reading" do
    assert_difference('VehicleReading.count', -1) do
      delete :destroy, id: @vehicle_reading
    end

    assert_redirected_to vehicle_readings_path
  end
end
