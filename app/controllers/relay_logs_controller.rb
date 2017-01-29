# == Schema Information
#
# Table name: relay_logs
#
#  id                 :integer          not null, primary key
#  relay_id           :integer          not null
#  request_method     :string
#  request_url        :string
#  request_parameters :text
#  request_headers    :text
#  request_body       :binary
#  response_status    :integer
#  response_headers   :text
#  response_body      :binary
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class RelayLogsController < ApplicationController
  before_action :set_relay
  before_action :set_relay_log, only: [:show, :edit, :update, :destroy]

  add_breadcrumb 'Relays', :relays_path
  before_action :add_relay_breadcrumb
  add_breadcrumb 'Logs'

  # GET /relay_logs
  # GET /relay_logs.json
  def index
    respond_to do |format|
      format.html
      format.json { @relay_logs = @relay.relay_logs.order(id: :desc).all }
    end
  end

  # GET /relay_logs/1
  # GET /relay_logs/1.json
  def show
  end

  # GET /relay_logs/new
  def new
    @relay_log = RelayLog.new
  end

  # GET /relay_logs/1/edit
  def edit
  end

  # POST /relay_logs
  # POST /relay_logs.json
  def create
    @relay_log = RelayLog.new(relay_log_params)

    respond_to do |format|
      if @relay_log.save
        format.html { redirect_to @relay_log, notice: 'Relay log was successfully created.' }
        format.json { render :show, status: :created, location: @relay_log }
      else
        format.html { render :new }
        format.json { render json: @relay_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relay_logs/1
  # PATCH/PUT /relay_logs/1.json
  def update
    respond_to do |format|
      if @relay_log.update(relay_log_params)
        format.html { redirect_to @relay_log, notice: 'Relay log was successfully updated.' }
        format.json { render :show, status: :ok, location: @relay_log }
      else
        format.html { render :edit }
        format.json { render json: @relay_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relay_logs/1
  # DELETE /relay_logs/1.json
  def destroy
    @relay_log.destroy
    respond_to do |format|
      format.html { redirect_to relay_logs_url, notice: 'Relay log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def add_relay_breadcrumb
    return unless @relay
    add_breadcrumb @relay.title, relay_path(@relay)
  end

  def set_relay
    @relay = Relay.where(id: params[:relay_id]).first
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_relay_log
    @relay_log = RelayLog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def relay_log_params
    params.require(:relay_log).permit(:relay_id, :request_method, :request_url, :request_parameters, :request_headers, :request_body, :response_status, :response_headers, :response_body)
  end
end
