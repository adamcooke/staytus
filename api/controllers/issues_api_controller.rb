controller :issues do

  action :all do
    action do
      issues = Issue.ordered.includes(:service_status, :user)
      issues.map { |i| structure(i, :full => true, :expansions => [:user, :service_status]) }
    end
  end

  action :info do
    param :issue, :required => true, :type => Integer
    action do
      issue = Issue.find_by_id(params.issue)
      unless issue
        error :not_found, "Issue not found with ID `#{params.issue}`"
      end
      structure(issue, :full => true, :expansions => true)
    end
  end

end
