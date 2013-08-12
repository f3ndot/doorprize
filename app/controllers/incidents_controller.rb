class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  def robots
    robots = File.read(Rails.root + "config/robots.#{Rails.env}.txt")
    render text: robots, layout: false, content_type: "text/plain"
  end

  # GET /incidents
  # GET /incidents.json
  def index
    sort_param = params.permit(:sort)[:sort]

    case sort_param
    when 'latest', 'newest'
      @incidents = Incident.latest_incidents
    when 'oldest'
      @incidents = Incident.oldest_incidents
    when 'latest-submitted', 'newest-submitted'
      @incidents = Incident.latest_submitted
    when 'oldest-submitted'
      @incidents = Incident.oldest_submitted
    when 'most-severe'
      @incidents = Incident.most_severe
    when 'least-severe'
      @incidents = Incident.least_severe
    else
      redirect_to incidents_path if sort_param.present?
      @incidents = Incident.all
    end
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
    @incident.build_car
  end

  # GET /incidents/1/edit
  def edit
    @incident.build_car if @incident.car.nil?
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        format.json { render action: 'show', status: :created, location: @incident }
      else
        format.html { render action: 'new' }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:description, :datetime_of_incident, :location, :injured, :police_report_number, :video, :severity, car_attributes: [:id, :description, :make, :color, :license_plate, :damage, :driver_name, :driver_contact])
    end
end
