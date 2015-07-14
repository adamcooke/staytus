controller :services do

  action :all do
    action do
      Service.ordered.includes(:status).map do |s|
        structure(s, :full => true, :expansions => [:status])
      end
    end
  end

  action :info do
    param :service, :required => true, :type => String
    action do
      service = Service.find_by_permalink(params.service)
      unless service
        error :not_found, "Service not found with permalink `#{params.service}`"
      end
      structure(service, :full => true, :expansions => true)
    end
  end

  action :set_status do
    param :service, :required => true, :type => String
    param :status, :required => true, :type => String
    action do
      service = Service.find_by_permalink(params.service)
      unless service
        error :not_found, "Service not found with permalink `#{params.service}`"
      end

      status = ServiceStatus.find_by_permalink(params.status)
      unless status
        error :not_found, "Service status not found with permalink `#{params.status}`"
      end

      service.status = status
      service.save
      structure(service, :full => true, :expansions => true)
    end
  end

end
