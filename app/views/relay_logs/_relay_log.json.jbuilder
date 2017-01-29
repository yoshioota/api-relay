json.extract! relay_log,
              :id,
              :relay_id,
              :request_method,
              :request_url,
              :request_parameters,
              :request_headers,
              :request_body_encoded,
              :request_body_if_fail_base64,
              :response_status,
              :response_headers,
              :response_body_encoded,
              :response_body_if_fail_base64,
              :created_at,
              :updated_at

json.url relay_log_url(relay_log, format: :json)
