class Admin::SubscribersController < Admin::BaseController

  before_filter { params[:id] && @subscriber = Subscriber.find(params[:id]) }

  def index
    @subscribers = Subscriber.ordered.page(params[:page])
  end

  def verify
    @subscriber.verify!
    redirect_to request.referer || admin_subscribers_path, :notice => "#{@subscriber.email_address} has been verified successfully"
  end

  def destroy
    @subscriber.destroy
    redirect_to request.referer || admin_subscribers_path, :notice => "#{@subscriber.email_address} has been removed successfully"
  end

end
