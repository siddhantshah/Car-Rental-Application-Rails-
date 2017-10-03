class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = Suggestion.all
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new
  end

  # GET /suggestions/1/edit
  def edit
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(suggestion_params)
    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to @suggestion, notice: 'Thank you for your suggestion!' }
        format.json { render :show, status: :created, location: @suggestion }
      else
        format.html { render :new }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestions/1
  # PATCH/PUT /suggestions/1.json
  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept_suggestion
    puts 'suggestion id: ' << params[:suggestion_id]
    @suggestion = Suggestion.where(:id => params[:suggestion_id])[0]
  end

  def accept_in_db
    @suggestion = Suggestion.where(:id => params[:suggestion_id])[0]
    @car = Car.new
    @car.location = params[:location]
    @car.manufacturer = params[:manufacturer]
    @car.model = params[:model]
    @car.style = params[:style]
    @car.license = params[:license]
    @car.rate= params[:rate]
    @car.status = 'Available'
    if @car.save!
      @suggestion.destroy
      redirect_to suggestions_path, notice: 'Car added to database!'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_params
      params.require(:suggestion).permit(:location, :model, :manufacturer, :style)
    end
end
