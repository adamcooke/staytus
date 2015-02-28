class PagesController < ApplicationController

  before_filter { prepend_view_path(File.join(Staytus::Config.theme_root, 'views')) }
  layout Staytus::Config.theme_name

  def index
    @services = Service.ordered.includes(:status, {:active_maintenances => :service_status}).to_a
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

end
