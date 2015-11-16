class VehicleReadingsController < ApplicationController
  before_action :set_vehicle_reading, only: [:show, :edit, :update, :destroy]

  # GET /vehicle_readings
  # GET /vehicle_readings.json
  def index
    
    # while (true) do
    #   VehicleReading.timingTest
    #   sleep (5)
    # end
    # VehicleReading.timingTest
   VehicleReading.ourMethod
    
  end

  # GET /vehicle_readings/1
  # GET /vehicle_readings/1.json
  def show
  end

  # GET /vehicle_readings/new
  def new
    @vehicle_reading = VehicleReading.new
  end

  # GET /vehicle_readings/1/edit
  def edit
  end

  # POST /vehicle_readings
  # POST /vehicle_readings.json
  def create
    @vehicle_reading = VehicleReading.new(vehicle_reading_params)

    respond_to do |format|
      if @vehicle_reading.save
        format.html { redirect_to @vehicle_reading, notice: 'Vehicle reading was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle_reading }
      else
        format.html { render :new }
        format.json { render json: @vehicle_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_readings/1
  # PATCH/PUT /vehicle_readings/1.json
  def update
    respond_to do |format|
      if @vehicle_reading.update(vehicle_reading_params)
        format.html { redirect_to @vehicle_reading, notice: 'Vehicle reading was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle_reading }
      else
        format.html { render :edit }
        format.json { render json: @vehicle_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_readings/1
  # DELETE /vehicle_readings/1.json
  def destroy
    @vehicle_reading.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_readings_url, notice: 'Vehicle reading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_reading
      @vehicle_reading = VehicleReading.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_reading_params
      params.require(:vehicle_reading).permit(:reading_id, :agency_id, :call_name, :current_stop_id, :heading, :vehicle_id, :latitude, :longitude, :route_id, :segment_id, :speed, :timestamp)
    end
end
