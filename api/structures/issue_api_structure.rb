structure :issue do
  basic :id
  basic :title
  basic :state
  basic :identifier

  full :created_at
  full :updated_at
  full :notify

  expansion :user do
    structure(o.user)
  end

  expansion :services, :structure => :service

  expansion :service_status do
    structure(o.service_status)
  end

  expansion :updates do
    o.updates.includes(:service_status, :user).order(:id).map { |u| structure(u, :full => true, :expansions => [:service_status, :user]) }
  end

end
