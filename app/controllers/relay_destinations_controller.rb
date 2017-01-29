# == Schema Information
#
# Table name: relay_destinations
#
#  id         :integer          not null, primary key
#  relay_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  base_url   :string
#

class RelayDestinationsController < ApplicationController
  before_action :set_relay
  before_action :set_relay_destination, only: [:show, :edit, :update, :destroy]

  # GET /relay_destinations
  # GET /relay_destinations.json
  def index
    @relay_destinations = @relay.relay_destinations.order(base_url: :asc).all
  end

  # GET /relay_destinations/1
  # GET /relay_destinations/1.json
  def show
  end

  # GET /relay_destinations/new
  def new
    @relay_destination = RelayDestination.new(relay_id: @relay.id)
  end

  # GET /relay_destinations/1/edit
  def edit
  end

  # POST /relay_destinations
  # POST /relay_destinations.json
  def create
    @relay_destination = RelayDestination.new(relay_destination_params)

    respond_to do |format|
      if @relay_destination.save
        format.html { redirect_to @relay, notice: 'Relay destination was successfully created.' }
        format.json { render :show, status: :created, location: [@relay, @relay_destination] }
      else
        format.html { render :new }
        format.json { render json: @relay_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relay_destinations/1
  # PATCH/PUT /relay_destinations/1.json
  def update
    respond_to do |format|
      if @relay_destination.update(relay_destination_params)
        format.html { redirect_to @relay, notice: 'Relay destination was successfully updated.' }
        format.json { render :show, status: :ok, location: [@relay, @relay_destination] }
      else
        format.html { render :edit }
        format.json { render json: @relay_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relay_destinations/1
  # DELETE /relay_destinations/1.json
  def destroy
    @relay_destination.destroy
    respond_to do |format|
      format.html { redirect_to @relay, notice: 'Relay destination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_relay
    @relay = Relay.find(params[:relay_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_relay_destination
    @relay_destination = RelayDestination.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def relay_destination_params
    params.require(:relay_destination).permit(:relay_id, :base_url)
  end
end
