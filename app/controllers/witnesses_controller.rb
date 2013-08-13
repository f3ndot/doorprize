class WitnessesController < ApplicationController
  before_action :set_witness, only: [:show, :edit, :update, :destroy]

  # GET /witnesses
  # GET /witnesses.json
  def index
    @witnesses = Witness.all
  end

  # GET /witnesses/1
  # GET /witnesses/1.json
  def show
  end

  # GET /witnesses/new
  def new
    @witness = Witness.new
  end

  # GET /witnesses/1/edit
  def edit
  end

  # POST /witnesses
  # POST /witnesses.json
  def create
    @witness = Witness.new(witness_params)

    respond_to do |format|
      if @witness.save
        format.html { redirect_to @witness, notice: 'Witness was successfully created.' }
        format.json { render action: 'show', status: :created, location: @witness }
      else
        format.html { render action: 'new' }
        format.json { render json: @witness.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /witnesses/1
  # PATCH/PUT /witnesses/1.json
  def update
    respond_to do |format|
      if @witness.update(witness_params)
        format.html { redirect_to @witness, notice: 'Witness was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @witness.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /witnesses/1
  # DELETE /witnesses/1.json
  def destroy
    @witness.destroy
    respond_to do |format|
      format.html { redirect_to witnesses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_witness
      @witness = Witness.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def witness_params
      params.require(:witness).permit(:name, :contact, :privacy_level, :incident_id)
    end
end
