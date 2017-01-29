class CurlCommandBuilder

  attr_accessor :request, :relay
  attr_accessor :url, :headers

  def initialize(relay, request)
    @relay = relay
    @request = request
    @url = nil
    @headers = nil
    # @params = nil
  end

  def build
    url = build_url
    curl_cmd = 'curl -v '

    dst_request_headers.each do |key, value|
      curl_cmd << "-H \"#{key}: #{value}\" \\\n"
    end

    curl_cmd << "\"#{url}\""

    curl_cmd
  end

  def dst_request_headers
    # (RequestUtils.get_headers(request))

    @headers = RequestUtils.get_headers(request)
    uri = Addressable::URI.parse(relay.active_relay_destination.base_url)
    host_with_port = uri.host
    host_with_port += ":#{uri.port}" if uri.port.present?
    # @headers.delete('Host')
    @headers['Host'] = host_with_port
    @headers
  end

  def build_url
    @url ||= File.join(relay.active_relay_destination.base_url, request.params[:paths])
    @url += ".#{request.parameters[:format]}" if request.parameters[:format].present?
    @url += "?#{request.query_string}" if request.query_string.present?
    @url
  end

  def base_url
    @basic_url ||= File.join(relay.active_relay_destination.base_url, request.params[:paths])
    @basic_url += ".#{request.parameters[:format]}" if request.parameters[:format].present?
  end

  def query_params
    request.query_params
  end
end
