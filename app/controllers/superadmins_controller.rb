class SuperadminsController < ApplicationController
  before_action :set_superadmin, only: [:show, :edit, :update, :destroy]

  # GET /superadmins
  # GET /superadmins.json
  def index
    @superadmins = Superadmin.all
  end

  # GET /superadmins/1
  # GET /superadmins/1.json
  def show
  end

  # GET /superadmins/new
  def new
    @superadmin = Superadmin.new
  end

  # GET /superadmins/1/edit
  def edit
  end

  # POST /superadmins
  # POST /superadmins.json
  def create
    @superadmin = Superadmin.new(superadmin_params)

    respond_to do |format|
      if @superadmin.save
        format.html { redirect_to @superadmin, notice: 'Superadmin was successfully created.' }
        format.json { render :show, status: :created, location: @superadmin }
      else
        format.html { render :new }
        format.json { render json: @superadmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /superadmins/1
  # PATCH/PUT /superadmins/1.json
  def update
    respond_to do |format|
      if @superadmin.update(superadmin_params)
        format.html { redirect_to @superadmin, notice: 'Superadmin was successfully updated.' }
        format.json { render :show, status: :ok, location: @superadmin }
      else
        format.html { render :edit }
        format.json { render json: @superadmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /superadmins/1
  # DELETE /superadmins/1.json
  def destroy
    @superadmin.destroy
    respond_to do |format|
      format.html { redirect_to superadmins_url, notice: 'Superadmin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_superadmin
      @superadmin = Superadmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def superadmin_params
      params.require(:superadmin).permit(:email, :name, :password)
    end
end
