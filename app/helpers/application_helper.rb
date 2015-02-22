module ApplicationHelper

  def maintenance_status_tag(status)
    content_tag :span, t("maintenance_statuses.#{status}"), :class => "maintenanceStatusTag maintenanceStatusTag--#{status}"
  end

  def service_status_tag(status)
    if status
      content_tag :span, status.name, :class => "serviceStatusTag serviceStatusTag--#{status.status_type}", :style => "color:##{status.color}"
    else
      content_tag :span, "Unknown", :class => "serviceStatusTag serviceStatusTag--unknown"
    end
  end

end
