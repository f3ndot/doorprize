class PopulationCentresController < ApplicationController
  load_and_authorize_resource
  before_action :set_population_centre, only: [:show, :edit, :update, :destroy]

  # GET /population_centres
  # GET /population_centres.json
  def index
    @population_centres = PopulationCentre.all
  end

  # GET /population_centres/1
  # GET /population_centres/1.json
  def show
  end

  # GET /population_centres/new
  def new
    @population_centre = PopulationCentre.new
  end

  # GET /population_centres/1/edit
  def edit
  end

  # POST /population_centres
  # POST /population_centres.json
  def create
    @population_centre = PopulationCentre.new(population_centre_params)

    respond_to do |format|
      if @population_centre.save
        format.html { redirect_to @population_centre, notice: 'Population centre was successfully created.' }
        format.json { render action: 'show', status: :created, location: @population_centre }
      else
        format.html { render action: 'new' }
        format.json { render json: @population_centre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /population_centres/1
  # PATCH/PUT /population_centres/1.json
  def update
    respond_to do |format|
      if @population_centre.update(population_centre_params)
        format.html { redirect_to @population_centre, notice: 'Population centre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @population_centre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /population_centres/1
  # DELETE /population_centres/1.json
  def destroy
    @population_centre.destroy
    respond_to do |format|
      format.html { redirect_to population_centres_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_population_centre
      @population_centre = PopulationCentre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def population_centre_params
      params.require(:population_centre).permit(:city, :province, :latitude, :longitude)
    end
end
