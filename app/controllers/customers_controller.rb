class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    if !current_superadmin or !current_admin
      if @customer.save then
        session[:customer_id] = @customer.id
        UserMailer.signup_confirmation(@customer).deliver
        redirect_to root_path
      end
    else
    respond_to do |format|
      if @customer.save
          format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
          format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    rental = Rental.where(:email => @customer.email).last!
    if !rental.empty?
      if rental.status.eql? "Checked out"
        redirect_to customers_url, notice: 'Customer has checked out a car and thus can not deleted until the car is returned.'
      else
        @customer.destroy
        if rental.status.eql? "Reserved"
          Rental.update(rental.id,:status => "Cancelled")
          car = Car.where(:license => rental.license)[0]
          Car.update(car.id, :status => "Available")
          # Nofify users who have subscribed about car availability
          @emails = Notify.where(:license => rental.license)
          @emails.each do |email|
            UserMailer.notify(email.email,car).deliver
            @notify = Notify.find_by_email_and_license(email.email, car.license)
            @notify.destroy
          end
        end
        respond_to do |format|
          format.html { redirect_to customers_url, notice: 'Customer was deleted, but it\'s rental history is preserved.' }
          format.json { head :no_content }
        end
      end
    end
  end

  def profile
    @customer = Customer.where(:id => session[:customer_id])
  end

  def notify_email
    @customer_id = session[:customer_id]
    @license = params[:license]
    @notify = Notify.new
    @notify.license = @license
    @notify.email= Customer.where(:id => @customer_id)[0].email
    @notify.save!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:email, :name, :password, :rental_charge)
    end

end

