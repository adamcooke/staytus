controller :subscribers do

  action :info do
    param :email_address
    param :verification_token
    action do
      if params.email_address
        subscriber = Subscriber.find_by_email_address!(params.email_address)
      elsif params.verification_token
        subscriber = Subscriber.find_by_verification_token!(params.verification_token)
      else
        error :parameter_error, "Must provide `email_address` or `verification_token` parameter"
      end
      structure subscriber, :full => true
    end
  end

  action :add do
    param :email_address, :required => true
    param :verified
    action do
      subscriber = Subscriber.new(:email_address => params.email_address)
      subscriber.verified_at = Time.now if params.verified.to_i == 1
      if subscriber.save
        structure subscriber, :full => true
      else
        error :validation_error, subscriber.errors
      end
    end
  end

  action :verify do
    param :email_address, :required => true
    action do
      subscriber = Subscriber.find_by_email_address!(params.email_address)
      subscriber.verify!
    end
  end

  action :send_verification_email do
    param :email_address, :required => true
    action do
      subscriber = Subscriber.find_by_email_address!(params.email_address)
      message = subscriber.send_verification_email
      {
        :message_id => message.message_id,
        :subject => message.subject,
        :body => message.body.raw_source
      }
    end
  end

  action :delete do
    param :email_address, :required => true
    action do
      deleted_items = Subscriber.where(:email_address => params.email_address).destroy_all
      deleted_items.map do |subscriber|
        strucutre subscriber
      end
    end
  end

end
