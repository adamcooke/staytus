structure :maintenance do
  basic :id
  basic :title
  full :description
  full :start_at
  full :finish_at
  full :length_in_minutes
  full :created_at
  full :updated_at
  full :identifier

  expansion :services

  expansion :updates

end
