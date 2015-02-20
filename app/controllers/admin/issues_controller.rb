class Admin::IssuesController < Admin::BaseController

  def index
    @ongoing_issues = Issue.ongoing.ordered
    @resolved_issues = Issue.resolved.ordered.page(params[:page])
  end

  def new
    @issue = Issue.new(:state => 'investigating')
  end

  def create
    @issue = Issue.new(safe_params)
    if @issue.save
      redirect_to admin_issues_path, :notice => 'Added succesfully'
    else
      render 'new'
    end
  end

  private

  def safe_params
    params.require(:issue).permit(:auto, :service_ids => [])
  end

end
