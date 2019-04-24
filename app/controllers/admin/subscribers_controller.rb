class Admin::SubscribersController < Admin::BaseController

  before_filter { params[:id] && @subscriber = Subscriber.find(params[:id]) }

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(safe_params)
    @subscriber.verified_at = Time.now
    if @subscriber.save
      redirect_to admin_subscribers_path, :notice => 'Subscriber has been created'
    else
      render 'new'
    end
  end

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

  private

  def safe_params
    params.require(:subscriber).permit(:email_address)
  end

end
