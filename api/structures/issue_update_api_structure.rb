structure :issue_update do
  basic :id
  basic :state
  basic :text
  basic :identifier
  full :created_at
  full :updated_at
  full :notify

  expansion :user do
    structure(o.user)
  end

  expansion :service_status do
    structure(o.service_status)
  end

end
