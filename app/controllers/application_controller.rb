class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :set_time_zone
  before_filter :ensure_site

  private

  def set_time_zone
    if has_site?
      Time.zone = site.time_zone
      Chronic.time_class = Time.zone
    end
    yield
    Chronic.time_class = Time
    Time.zone = nil
  end

  def site
    @site ||= Site.first || :none
  end
  helper_method :site

  def has_site?
    site.is_a?(Site)
  end
  helper_method :has_site?

  def ensure_site
    unless site.is_a?(Site)
      redirect_to setup_path(:step1)
    end
  end

end
