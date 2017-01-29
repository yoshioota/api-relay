json.extract! relay, :id, :title, :max_logs_size, :active_relay_destination_id, :created_at, :updated_at
json.url relay_url(relay, format: :json)

json.active_relay_destination do
  if relay.active_relay_destination
    json.partial! relay.active_relay_destination, partial: 'relay_destinations/relay_destination'
  else
    nil
  end
end

json.relay_destinations do
  json.array! relay.relay_destinations, partial: 'relay_destinations/relay_destination', as: :relay_destination
end
