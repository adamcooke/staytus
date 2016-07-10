class PagesController < ApplicationController

  before_filter { prepend_view_path(File.join(Staytus::Config.theme_root, 'views')) }
  layout Staytus::Config.theme_name

  def index
    @services = Service.ordered.includes(:group, :status, {:active_maintenances => :service_status})
    @services_with_group = @services.group_by(&:group).sort_by { |g,_| g ? g.name : 'zzz' }
    @issues = Issue.ongoing.ordered.to_a
    @maintenances = Maintenance.open.ordered.to_a
  end

  def issue
    @issue = Issue.find_by_identifier!(params[:id])
    @updates = @issue.updates.includes(:user).ordered
  end

  def maintenance
    @maintenance = Maintenance.find_by_identifier!(params[:id])
    @updates = @maintenance.updates.includes(:user).ordered
  end

  def history
    @items = HistoryItem.includes(:item).ordered.page(params[:page])
  end

  def robots
    text = []
    text << "User-agent: *"
    text << "Disallow: /admin"
    unless site.crawling_permitted?
      text << "Disallow: /"
    end
    render :text => text.join("\n"), :content_type => 'text/plain'
  end

  def subscriber_verification
    @subscriber = Subscriber.find_by_verification_token!(params[:token])
    @subscriber.verify!
  end

  def unsubscribe
    if @subscriber = Subscriber.find_by_verification_token(params[:token])
      @subscriber.destroy
      redirect_to root_path, :notice => "You have been successfully unsubscribed. You won't receive any further e-mails from us."
    else
      redirect_to root_path, :alert => "Seems like you have already unsubscribed."
    end
  end

  before_filter :check_whether_subscriptions_are_enabled, :only => [:subscribe, :subscribe_by_email]

  def subscribe
  end

  def subscribe_by_email
    @subscriber = Subscriber.new(:email_address => params[:email_address])
    if @subscriber.save
      @subscriber.send_verification_email
      redirect_to root_path, :notice => "Thanks - please check your email and click the link within to confirm your subscription."
    else
      redirect_to subscribe_path, :alert => "The e-mail address you have entered is either invalid or already subscribed to the status site."
    end
  end

  private

  def check_whether_subscriptions_are_enabled
    unless site.allow_subscriptions?
      redirect_to root_path
    end
  end

end
