class Admin::IssueUpdatesController < Admin::BaseController

  before_filter { @issue = Issue.find(params[:issue_id]) }
  before_filter { params[:id] && @issue_update = @issue.updates.find(params[:id]) }

  def create
    @update = @issue.updates.build(safe_params)
    if @update.save
      redirect_to admin_issue_path(@issue), :notice => "Update has been posted successfully."
    else
      redirect_to admin_issue_path(@issue), :alert => @update.errors.full_messages.to_sentence
    end
  end

  private

  def safe_params
    params.require(:issue_update).permit(:auto)
  end

end
