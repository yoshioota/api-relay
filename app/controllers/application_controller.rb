class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :set_timezone

  private

  def set_timezone
    Time.zone = 'Asia/Tokyo'
  end
end
