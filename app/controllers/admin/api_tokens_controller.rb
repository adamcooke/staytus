class Admin::ApiTokensController < Admin::BaseController

  before_filter { params[:id] && @api_token = ApiToken.find(params[:id]) }

  def index
    @api_tokens = ApiToken.ordered
  end

  def new
    @api_token = ApiToken.new
  end

  def create
    @api_token = ApiToken.new(safe_params)
    if @api_token.save
      redirect_to admin_api_tokens_path, :notice => "#{@api_token.name} has been added successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @api_token.update_attributes(safe_params)
      redirect_to admin_api_tokens_path, :notice => "#{@api_token.name} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @api_token.destroy
    redirect_to admin_api_tokens_path, :notice => "#{@api_token.name} has been removed successfully."
  end

  private

  def safe_params
    params.require(:api_token).permit(:auto)
  end

end
