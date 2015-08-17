controller :issues do

  action :all do
    action do
      issues = Issue.ordered.includes(:service_status, :user)
      issues.map { |i| structure(i, :full => true, :expansions => [:user, :service_status]) }
    end
  end

  action :create do
    param :title, :required => true, :type => String
    param :initial_update, :required => false, :type => String
    param :state, :required => false, :type => String
    param :services, :required => true, :type => Array
    param :status, :required => true, :type => String
    param :notify, :required => false

    action do
      issue_params = {
        title: params.title,
        initial_update: params.initial_update,
        state: params.state,
        service_ids: Service.where(permalink: params.services).pluck(:id),
        service_status_id: ServiceStatus.where(permalink: params.status).first.id,
        notify: params.notify
      }

      issue = Issue.new issue_params
      if issue.save
        structure issue, :full => true
      else
        error :validation_error, issue.errors
      end
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
