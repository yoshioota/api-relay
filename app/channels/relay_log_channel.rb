class RelayLogChannel < ApplicationCable::Channel
  def subscribed
    stream_from "relay_log_#{params[:relay_id]}"
  end

  def unsubscribed
  end

  def watch(relay_id)
    ActionCable.server.broadcast "relay_log_#{relay_id}", Time.now.iso8601(4)
  end
end
