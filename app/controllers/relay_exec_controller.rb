class RelayExecController < ApplicationController
  before_action :set_relay

  def exec
    relay_log = relay!
    broadcast!(relay_log)
    set_response_header(relay_log, response)
    delete_logs_if_limit_over

    render body: relay_log.response_body,
           status: relay_log.response_status,
           content_type: relay_log.response_headers_hash['Content-Type']
  end

  private

  def relay!
    builder = CurlCommandBuilder.new(@relay, request)

    typhoeus_request = Typhoeus::Request.new(
        builder.base_url,
        params: request.query_parameters,
        headers: builder.dst_request_headers,
        body: request.raw_post,
        method: request.request_method.downcase.to_sym)

    typhoeus_response = typhoeus_request.run

    relay_log = @relay.relay_logs.build
    relay_log.request_method = request.request_method
    relay_log.request_url = builder.build_url
    relay_log.request_headers = JSON.pretty_generate(builder.dst_request_headers)
    relay_log.request_parameters = JSON.pretty_generate(request.query_parameters)
    relay_log.request_body = request.raw_post
    relay_log.response_status = typhoeus_response.code
    relay_log.response_headers = JSON.pretty_generate(typhoeus_response.headers)
    relay_log.response_body = typhoeus_response.body
    relay_log.save!
    relay_log
  end

  def broadcast!(relay_log)
    json = ApplicationController.renderer.render(partial: 'relay_logs/relay_log', locals: { relay_log: relay_log }, format: :json)
    ActionCable.server.broadcast "relay_log_#{relay_log.relay_id}", json
  end

  def set_response_header(relay_log, response)
    headers = relay_log.response_headers_hash
    headers.select do |key, value|
      next if 'Content-Length' == key
      response.headers[key] = value
    end
  end

  def delete_logs_if_limit_over
    return if (offset = @relay.max_logs_size.to_i).zero?
    return unless relay_log_id = @relay.relay_logs.order(id: :desc).offset(offset).select(:id).first
    @relay.relay_logs.where('id <= ?', relay_log_id).delete_all
  end

  def set_relay
    @relay = Relay.find(params[:id])
  end
end
