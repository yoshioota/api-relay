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

class RelayLog < ApplicationRecord
  belongs_to :relay

  def request_headers_hash
    request_headers.present? ? JSON.parse(request_headers) : {}
  end

  def request_parameters_hash
    request_parameters.present? ? JSON.parse(request_parameters) : {}
  end

  def response_headers_hash
    response_headers.present? ? JSON.parse(response_headers) : {}
  end

  def request_body_encoded
    request_body_if_fail_base64
    @request_body_encoded
  end

  def request_body_if_fail_base64
    s = request_body.to_s
    begin
      @request_body_if_fail_base64 ||= s.encode(Encoding::UTF_8)
      @request_body_encoded ||= false
    rescue
      @request_body_if_fail_base64 ||= Base64.encode64(s)
      @request_body_encoded ||= true
    end
    @request_body_if_fail_base64
  end

  def response_body_encoded
    response_body_if_fail_base64
    @response_body_encoded
  end

  def response_body_if_fail_base64
    s = response_body.to_s
    begin
      @response_body_if_fail_base64 ||= s.encode(Encoding::UTF_8)
      @response_body_encoded ||= false
    rescue
      @response_body_if_fail_base64 ||= Base64.encode64(s)
      @response_body_encoded ||= true
    end
    @response_body_if_fail_base64
  end
end
