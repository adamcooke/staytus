class Admin::UsersController < Admin::BaseController

  before_filter { params[:id] && @user = User.find(params[:id]) }

  def index
    @users = User.ordered
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(safe_params)
    if @user.save
      redirect_to admin_users_path, :notice => "#{@user.name} has been added successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(safe_params)
      redirect_to admin_users_path, :notice => "#{@user.name} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    if @user == current_user
      redirect_to [:edit, :admin, @user], :alert => "You cannot remove yourself."
      return
    end

    @user.destroy
    redirect_to admin_users_path, :notice => "#{@user.name} has been removed successfully."
  end

  private

  def safe_params
    params.require(:user).permit(:auto)
  end

end
