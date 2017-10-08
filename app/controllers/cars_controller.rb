class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @rental = Rental.where(:license => @car.license, :status => 'Checked out')
    if !@rental.empty?
      redirect_to cars_url, notice: 'Car has been checked out thus can not be deleted until returned.'
    else
      @rental = Rental.where(:license => @car.license, :status => 'Reserved')
      @rental.each do |r|
        Rental.update(r.id,:status => "Cancelled")
      end
      @car.destroy
      respond_to do |format|
        format.html { redirect_to cars_url, notice: 'Car was successfully destroyed and it\'s reservations were cancelled.' }
        format.json { head :no_content }
      end
    end
  end

  def search_cars
    @cars = Car.all
    @location = params[:location]
    @model = params[:model]
    @manufacturer = params[:manufacturer]
    @style = params[:style]
    @status = params[:status]
    if( !@manufacturer.nil? and !@manufacturer.empty?)
      @cars = @cars.where(:manufacturer => @manufacturer)
    end
    if( !@model.nil? and !@model.empty?)
      @cars = @cars.where(:model => @model)
    end
    if( !@location.nil? and !@location.empty?)
      @cars = @cars.where(:location => @location)
    end
    if(!@style.nil? and !@style.empty?)
      @cars = @cars.where(:style => @style)
    end
    if(!@style.nil? and !@status.empty?)
      @cars = @cars.where(:status => @status)
    end
  end

  # def suggestion
  #   @suggestion = Suggestion.new
  #   @suggestion.location = params[:location]
  #   @suggestion.model = params[:model]
  #   @suggestion.manufacturer = params[:manufacturer]
  #   @suggestion.style = params[:style]
  #   if @suggestion.save!
  #     redirect_to '/customer_profile'
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:license, :manufacturer, :model, :rate, :style, :location, :status)
    end
end
