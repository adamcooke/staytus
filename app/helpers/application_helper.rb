module ApplicationHelper

  def maintenance_status_tag(status)
    content_tag :span, t("maintenance_statuses.#{status}"), :class => "maintenanceStatusTag maintenanceStatusTag--#{status}"
  end

  def service_status_tag(status)
    case status
    when ServiceStatus then service_status_tag_for_status(status)
    when Service then service_status_tag_for_service(status)
    else
    end
  end

  def service_status_tag_for_service(service)
    if maintenance = service.active_maintenances.first
      service_status_tag_for_status(maintenance.service_status)
    else
      service_status_tag_for_status(service.status)
    end
  end

  def service_status_tag_for_status(status)
    if status
      content_tag :span, status.name, :class => "serviceStatusTag serviceStatusTag--#{status.status_type}", :style => "color:##{status.color}"
    else
      content_tag :span, "Unknown", :class => "serviceStatusTag serviceStatusTag--unknown"
    end
  end

end
