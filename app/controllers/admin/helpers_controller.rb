class Admin::HelpersController < ApplicationController

  def chronic
    date = Chronic.parse(params[:string])
    render :json => {
      :raw => date,
      :formatted => date ? date.to_s(:long) :nil,
      :nice => date ? Datey::Formatter.new(date).date_and_time : nil
    }
  end

end
