if ENV['STAYTUS_SMTP_HOSTNAME']
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :user_name  => ENV['STAYTUS_SMTP_USERNAME'],
    :password   => ENV['STAYTUS_SMTP_PASSWORD'],
    #:domain => 'yourdomain.com',
    :address    => ENV['STAYTUS_SMTP_HOSTNAME'],
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true

  }
else
  puts "\e[33m=> You haven't configured an SMTP server. Mail will be sent using sendmail.\e[0m"
  ActionMailer::Base.delivery_method = :sendmail
end

Mail.defaults do
  if ActionMailer::Base.delivery_method == :smtp
    delivery_method :smtp, ActionMailer::Base.smtp_settings
  else
    delivery_method ActionMailer::Base.delivery_method
  end
end
