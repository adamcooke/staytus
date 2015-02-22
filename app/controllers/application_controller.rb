class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :set_time_zone

  private

  def set_time_zone
    Time.zone = site.time_zone
    Chronic.time_class = Time.zone
    yield
    Chronic.time_class = Time
    Time.zone = nil
  end

  def site
    @site ||= Site.first
  end
  helper_method :site

end
