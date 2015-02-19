class Admin::SessionsController < Admin::BaseController

  layout 'login'
  skip_before_filter :login_required, :only => [:new, :create]

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.is_a?(User)
      self.current_user = user
      redirect_to admin_root_path
    else
      flash.now.alert = 'The email address and/or password entered was incorrect. Please check and try again.'
      render 'new'
    end
  end

  def destroy
    auth_session.invalidate!
    redirect_to admin_login_path, :notice => "Logged out successfully."
  end

end
