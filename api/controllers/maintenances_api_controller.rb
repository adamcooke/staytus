controller :maintenances do
  
    action :all do
      action do
        Maintenance.ordered.includes(:services).map do |s|
          structure(s, :full => true, :expansions => [:services])
        end
      end
    end

    action :info do
      param :maintenance, :required => true, :type => Integer
      action do
        maintenance = Maintenance.find_by_id(params.maintenance)
        unless maintenance
          error :not_found, "Maintenance not found with ID `#{params.maintenance}`"
        end
        structure(maintenance, :full => true, :expansions => true)
      end
    end

    action :upcoming do
      action do
        Maintenance.ordered.where("start_at > NOW()").includes(:services).map do |s|
          structure(s, :full => true, :expansions => [:services])
        end
      end
    end
  
  end
  
