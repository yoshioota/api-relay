module ApplicationHelper
  def title_helper
    t("title.#{controller_path}.#{action_name}", default: '').presence ||
        "#{controller_path} #{action_name}".titleize
  end

  def relay_point_url(relay)
    File.join "#{request.scheme}://#{request.host_with_port}", relay.relay_point_path
  end
end
