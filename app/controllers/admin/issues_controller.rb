class Admin::IssuesController < Admin::BaseController

  before_filter { params[:id] && @issue = Issue.find(params[:id]) }

  def index
    @ongoing_issues = Issue.ongoing.ordered.includes(:latest_update, :service_status, :user)
  end

  def resolved
    @issues = Issue.resolved.ordered.includes(:latest_update, :service_status, :user).page(params[:page])
  end

  def show
    @update = @issue.updates.build(:state => @issue.state, :service_status => @issue.service_status)
    @updates = @issue.updates.ordered
  end

  def new
    @issue = Issue.new(:state => 'investigating')
  end

  def create
    @issue = Issue.new(safe_params)
    @issue.user = current_user
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
