class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  # GET /incidents
  # GET /incidents.json
  def index
    safe_params = params.permit :sort, :page, :user
    @sortable_words = {latest: 'Latest incidents', oldest: 'Oldest incidents', latest_submitted: 'Newest submissions', oldest_submitted: 'Oldest submissions', most_severe: 'Most severe', least_severe: 'Least severe'}

    case safe_params[:sort]
    when 'latest', 'newest'
      incidents = Incident.latest_incidents
      sorted_by = 'Latest incidents'
    when 'oldest'
      incidents = Incident.oldest_incidents
      sorted_by = 'Oldest incidents'
    when 'latest-submitted', 'newest-submitted'
      incidents = Incident.latest_submitted
      sorted_by = 'Newest submissions'
    when 'oldest-submitted'
      incidents = Incident.oldest_submitted
      sorted_by = 'Oldest submissions'
    when 'most-severe'
      incidents = Incident.most_severe
      sorted_by = 'Most severe'
    when 'least-severe'
      incidents = Incident.least_severe
      sorted_by = 'Least severe'
    when 'least-severe'
      incidents = Incident.least_severe
      sorted_by = 'Least severe'
    else
      redirect_to incidents_path if safe_params[:sort].present?
      sorted_by = 'Latest incidents'
      incidents = Incident.latest_incidents
    end

    if safe_params[:user].present?
      user = User.find(safe_params[:user])
      sorted_by << " by #{user.email}"
      incidents = incidents.by_user user
    end

    @sorted_by = sorted_by
    @incidents = incidents.page safe_params[:page]
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
    @incident.user = current_user if user_signed_in?

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        format.json { render action: 'show', status: :created, location: @incident }
      else
        @incident.build_car if @incident.car.nil?
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
      params.require(:incident).permit(:description, :datetime_of_incident, :location, :police_report_number, :video, :severity, car_attributes: [:id, :description, :make, :color, :license_plate, :damage, :driver_name, :driver_contact], witnesses_attributes: [:id, :name, :privacy_level, :contact, :_destroy])
    end
end
