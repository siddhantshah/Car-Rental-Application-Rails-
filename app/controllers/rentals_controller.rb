class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]

  # GET /rentals
  # GET /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1
  # GET /rentals/1.json
  def show
  end

  # GET /rentals/new
  def new
    @rental = Rental.new
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals
  # POST /rentals.json
  def create
    @rental = Rental.new(rental_params)

    respond_to do |format|
      if @rental.save
        format.html { redirect_to @rental, notice: 'Rental was successfully created.' }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1
  # PATCH/PUT /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to @rental, notice: 'Rental was successfully updated.' }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1
  # DELETE /rentals/1.json
  def destroy
    @rental.destroy
    respond_to do |format|
      format.html { redirect_to rentals_url, notice: 'Rental was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_reserve_car
    @customer = current_customer
    @previous_rental = Rental.where(:email => @customer.email).last
    if @previous_rental.nil? then
       redirect_to :controller => "rentals", :action => "reserve_car", :license => params[:license]
    elsif  @previous_rental.status.equal?('finish') then
      redirect_to :controller => "rentals", :action => "reserve_car", :license => params[:license]
    else
      redirect_to '/customer_profile'
    end
  end

  def reserve_car
    @car = Car.where(:license => params[:license])
  end

  def reserve_in_db
    @email = current_customer.email
    @license = params[:license]
    @checkout = params[:checkout]
    @return = params[:return]
    @hours = 3
    @rental_charge = @hours*Car.where(:license => @license)[0].rate
    @rental = Rental.new
    @rental.email= @email
    @rental.license= @license
    @rental.checkout= @checkout
    @rental.return= @return
    @rental.hours= @hours
    @rental.rental_charge= @rental_charge
    @rental.status= 'Reserved'
    @car = Car.where(:license => @license)[0]
    @car.status= 'Reserved'
    @customer = Customer.where(:email => @email)[0]
    @customer.rental_charge= @rental_charge
    if @rental.save! and @car.save! and @customer.save!
      redirect_to :controller => "rentals", :action => "car_reserved", :email => @email, :license => @license,
                  :checkout => @checkout, :return => @return
    else
      redirect_to '/signup'
    end
    end

  def car_reserved
    @car = Car.where(:license => params[:license])
  end

  def checkout
    @rental = Rental.where(:email => current_customer.email).last!
    Rental.update(@rental.id, :status => "progress")
    @car = Car.where(:license => @rental.license)[0];
    Car.update(@car.id, :status => "Checked out")
  end

  def checkout_history
    if !params[:customer].nil?
      @rentals = Rental.where(:email => params[:customer])
    else
      @rentals = Rental.where(:license => params[:license])
    end
  end

  def notify
    @rental = Rental.where(:email => current_customer.email).last!
    if  @rental.status == "progress"
      redirect_to '/signup'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rental_params
      params.require(:rental).permit(:email, :license, :checkout, :return, :hours, :rental_charge, :status)
    end


end
