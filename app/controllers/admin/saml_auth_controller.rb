class Admin::SamlAuthController < Admin::BaseController

  skip_before_action :verify_authenticity_token, :only => [:create]
  skip_before_action :login_required

  def create
    auth_hash = request.env['omniauth.auth']
    Rails.logger.info( auth_hash.inspect)
    email = auth_hash["uid"]
    user = User.find_by(email_address: email)
    user ||= User.create!(email_address: email,
                        name: auth_hash['extra']['raw_info']['cn'],
                        password: SecureRandom.hex(15),
                        )
    self.current_user = user
    redirect_to admin_root_path
  end

  def failure
    redirect_to root_path, :notice => "Sorry, Failed to login with saml SSO"
  end

end
