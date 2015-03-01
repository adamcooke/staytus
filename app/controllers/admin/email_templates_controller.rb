class Admin::EmailTemplatesController < Admin::BaseController

  def index
    @templates = EmailTemplate.pluck(:name)
  end

  def edit
    @default = I18n.translate("email_templates")[params[:id].to_sym]
    raise Status::Error, "Invalid template name" unless @default.is_a?(Hash)
    @default_content = File.read(Rails.root.join("app", "views", "emails", "#{params[:id]}.txt"))
    @template = EmailTemplate.find_by_name(params[:id])
    @template = EmailTemplate.new(:name => params[:id]) if @template.nil?
  end

  def update
    edit
    @template.attributes = params.require(:email_template).permit(:auto)
    if @template.save
      redirect_to admin_email_templates_path, :notice => "#{@default[:name]} has been updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @template = EmailTemplate.find_by_name!(params[:id])
    @template.destroy
    redirect_to admin_email_templates_path, :notice => "Template has been reverted successfully."
  end

end
