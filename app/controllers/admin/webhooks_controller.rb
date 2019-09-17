class Admin::WebhooksController < Admin::BaseController

  before_action { params[:id] && @webhook = Webhook.find(params[:id]) }

  def index
    @webhooks = Webhook.ordered.page(params[:page])
  end

  def new
    @webhook = Webhook.new
  end

  def create
    @webhook = Webhook.new(safe_params)
    if @webhook.save
      redirect_to admin_webhooks_path, :notice => "#{@webhook.name} has been added successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @webhook.update_attributes(safe_params)
      redirect_to admin_webhooks_path, :notice => "#{@webhook.name} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @webhook.destroy
    redirect_to admin_webhooks_path, :notice => "#{@webhook.name} has been removed successfully."
  end

  private

  def safe_params
    params.require(:webhook).permit(:name, :url)
  end

end
