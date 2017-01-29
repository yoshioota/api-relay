# == Schema Information
#
# Table name: relays
#
#  id                          :integer          not null, primary key
#  title                       :string
#  max_logs_size               :integer
#  active_relay_destination_id :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class RelaysController < ApplicationController
  before_action :set_relay, only: [:show, :edit, :update, :destroy]

  add_breadcrumb 'Relays', :relays_path
  before_action :set_relay_show_breadcrumb, only: [:show, :edit]
  add_breadcrumb 'Detail', nil, only: [:show]
  add_breadcrumb 'New', nil, only: [:new, :create]
  add_breadcrumb 'Edit', nil, only: [:edit, :update]

  # GET /relays
  # GET /relays.json
  def index
    respond_to do |format|
      format.html
      format.json { @relays = Relay.all }
    end
  end

  # GET /relays/1
  # GET /relays/1.json
  def show
  end

  # GET /relays/new
  def new
    @relay = Relay.new
  end

  # GET /relays/1/edit
  def edit
    # add_breadcrumb @relay.title, relay_path(@relay)
  end

  # POST /relays
  # POST /relays.json
  def create
    @relay = Relay.new(relay_params)

    respond_to do |format|
      if @relay.save
        format.html { redirect_to @relay, notice: 'Relay was successfully created.' }
        format.json { render :show, status: :created, location: @relay }
      else
        format.html { render :new }
        format.json { render json: @relay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relays/1
  # PATCH/PUT /relays/1.json
  def update
    respond_to do |format|
      if @relay.update(relay_params)
        format.html { redirect_to @relay, notice: 'Relay was successfully updated.' }
        format.json { render :show, status: :ok, location: @relay }
      else
        format.html { render :edit }
        format.json { render json: @relay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relays/1
  # DELETE /relays/1.json
  def destroy
    @relay.destroy
    respond_to do |format|
      format.html { redirect_to relays_url, notice: 'Relay was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_relay_show_breadcrumb
    add_breadcrumb @relay.title, relay_path(@relay)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_relay
    @relay = Relay.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def relay_params
    params.require(:relay).permit(:title, :max_logs_size, :active_relay_destination_id)
  end
end
