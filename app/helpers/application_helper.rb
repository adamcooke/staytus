module ApplicationHelper

  def distance_of_time_in_words_to_now_with_direction(time)
    string = distance_of_time_in_words_to_now(time)
    time > Time.now ? "in #{string}" : "#{string} ago"
  end

  def maintenance_status_tag(status)
    content_tag :span, t("maintenance_statuses.#{status}"), :class => "maintenanceStatusTag maintenanceStatusTag--#{status}"
  end

  def markdown(markdown, **options)
    mr = Staytus::MarkdownRenderer.new(options.merge(with_toc_data: true))
    rc = Redcarpet::Markdown.new(mr, space_after_headers: true, fenced_code_blocks: true, no_intra_emphasis: true, highlight: true, autolink: true, strikethrough: true, superscript: true, footnotes: true)
    rc.render(markdown.to_s).html_safe
  end

  def service_status_tag(status, options = {})
    case status
    when ServiceStatus then service_status_tag_for_status(status, options)
    when Service then service_status_tag_for_service(status, options)
    else
    end
  end

  def service_status_tag_for_service(service, options = {})
    if maintenance = service.active_maintenances.first
      status = service_status_tag_for_status(maintenance.service_status)
      if options[:link_maintenance] == :admin
        link_to(status, [:admin, maintenance])
      else
        status
      end
    else
      service_status_tag_for_status(service.status)
    end
  end

  def service_status_tag_for_status(status, options = {})
    if status
      content_tag :span, status.name, :class => "serviceStatusTag serviceStatusTag--#{status.status_type}", :style => "color:##{status.color}"
    else
      content_tag :span, "Unknown", :class => "serviceStatusTag serviceStatusTag--unknown"
    end
  end

end
