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
        datetime1 = DateTime.strptime(@checkout, '%Y-%m-%dT%H:%M')
        datetime2 = DateTime.strptime(@return, '%Y-%m-%dT%H:%M')
        time_delay =(datetime2-datetime1)/1.minutes
        @rental.delay(run_at: time_delay.minutes.from_now).return
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
    if current_admin or current_superadmin
      @customer = Customer.where(:email => params[:customer])[0]
    else
      @customer = current_customer
    end
    @previous_rental = Rental.where(:email => @customer.email).last
    puts @previous_rental
    if @previous_rental.nil? or @previous_rental.status.eql?('Returned') or @previous_rental.status.eql?('Cancelled') then
      redirect_to :controller => "rentals", :action => "reserve_car", :license => params[:license], :email => @customer.email
    else
      redirect_to '/customer_profile'
    end
  end

  def reserve_car
    @car = Car.where(:license => params[:license])
  end

  def reserve_in_db
    @status=params[:status]
    @license = params[:license]
    @checkout = params[:checkout]
    @return = params[:return]
    datetime1 = DateTime.strptime(@checkout, '%Y-%m-%dT%H:%M')
    datetime2 = DateTime.strptime(@return, '%Y-%m-%dT%H:%M')
    @hours = datetime2.hour.to_i - datetime1.hour.to_i
    @total_time = @return.to_datetime - @checkout.to_datetime

    @rental_charge = @hours*Car.where(:license => @license)[0].rate
    if current_admin and (!params[:email].nil? or !params[:email].empty?)
      @email = params[:email]
    else
      @email = current_customer.email
    end
    if @checkout.present? && !(@checkout > DateTime.now && @checkout <DateTime.now+7.days)
      redirect_to :controller => "rentals", :action => "reserve_car", :license => params[:license], :email => @email, notice: 'You can reserve for a timeline upto next 7 days only'
    elsif datetime2<datetime1
      redirect_to :controller => "rentals", :action => "reserve_car", :license =>params[:license], :email => @email, notice: 'Return time cannot be less than checkouttime '
    elsif !((datetime2.hour.to_i - datetime1.hour.to_i) >= 1 and (datetime2.hour.to_i - datetime1.hour.to_i).to_i <= 10)
      redirect_to :controller => "rentals", :action => "reserve_car", :license => params[:license], :email => @email, notice: 'You can reserve for at least one and at most 10 hours'
    else
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
      end
    end
  end

  def car_reserved
    @car = Car.where(:license => params[:license])
  end

  def cancel_reservation
    if current_customer
      @license = Rental.where(:email => Customer.where(:id => session[:customer_id])[0].email).last!.license
      @rental = Rental.where(:email => Customer.where(:id => session[:customer_id])[0].email).last!
      Rental.update(@rental.id,:status => "Cancelled")
      @car = Car.where(:license => @license)[0];
      Car.update(@car.id, :status => "Available")

      # Notify users who have subscribed about car availability
      @emails = Notify.where(:license => @license)
      @emails.each do |email|
        UserMailer.notify(email.email,@car).deliver
        @notify = Notify.find_by_email_and_license(email.email, @car.license)
        @notify.destroy
      end
    end

    if(current_customer)
      redirect_to '/customer_profile', notice: 'Cancellation successful.'
    end

    if(current_admin || current_superadmin)
      session[:customer_id] = nil
      if(current_admin)
        redirect_to '/admin_profile', notice: 'Cancellation successful.'
      elsif(current_superadmin)
        redirect_to '/superadmin_profile', notice: 'Cancellation successful.'
      end
    end
  end

  def checkout
    @rental = Rental.where(:email => current_customer.email).last!
    Rental.update(@rental.id, :status => "Checked out")
    @car = Car.where(:license => @rental.license)[0];
    Car.update(@car.id, :status => "Checked out")

    if(current_customer)
      redirect_to '/customer_profile', notice: 'Checked out successfully'
    end

    if(current_admin || current_superadmin)
      session[:customer_id] = nil
      if(current_admin)
        redirect_to '/admin_profile', notice: 'Checked out successfully'
      elsif(current_superadmin)
        redirect_to '/superadmin_profile', notice: 'Checked out successfully'
      end
    end
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

  def return
    if current_customer
      @license = Rental.where(:email => Customer.where(:id => session[:customer_id])[0].email).last!.license
      @rental = Rental.where(:email => Customer.where(:id => session[:customer_id])[0].email).last!
      Rental.update(@rental.id,:status => "Returned")
      @car = Car.where(:license => @license)[0];
      Car.update(@car.id, :status => "Available")

      # Notify users who have subscribed about car availability
      @emails = Notify.where(:license => @license)
      @emails.each do |email|
        UserMailer.notify(email.email,@car).deliver
        @notify = Notify.find_by_email_and_license(email.email, @car.license)
        @notify.destroy
      end
    end

    if(current_customer)
      redirect_to '/customer_profile', notice: 'Returned successfully'
    end

    if(current_admin || current_superadmin)
      session[:customer_id] = nil
      if(current_admin)
        redirect_to '/admin_profile', notice: 'Returned successfully'
      elsif(current_superadmin)
        redirect_to '/superadmin_profile', notice: 'Returned successfully'
      end
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
