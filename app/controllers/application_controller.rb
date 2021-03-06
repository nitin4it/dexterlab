class ApplicationController < ActionController::Base
  protect_from_forgery :secret => '8fc080370e56e929a2d5afca5540a0f7'
  
  respond_to :js, :html
  #If value not found
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
  rescue_from ActionController::UnknownAction, :with => :render_404
  rescue_from ActionController::RoutingError, :with => :render_404
  #rescue_from ActionController::RoutingError, :with => :redirect_to_root_path

  private
  def render_404(exception = nil)
    if exception
        logger.info "Rendering 404: #{exception.message}"
    end

    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
  #set date format in dd/mm/yyyy format
  def date_format(date_value)
    date_value.strftime("%d/%m/%Y")
  end

  # set date format for active record
  def date_strip(date_value)
     Date.strptime(date_value, "%d/%m/%Y" )
  end

  # Remove single quote and double quote from params
  def remove_special_character(value)
    value.gsub("'","")
  end
  
  #Redirect to requested url if ActiveRecord::RecordNotFound error generates
  def redirect_if_not_found
    flash[:error] = "Sorry, the system couldn&#8217;t find what you were looking for.".html_safe
    redirect_to '/' + controller_path
  end

  #if user is doing first time login , then redirect to account page
  def redirect_to_account_page!
    unless current_user.user_information.is_registered?
      flash[:error] = "Kindly complete your registration first.".html_safe
      redirect_to account_url
    end
  end

  # Redirect to home page if routing error generates
  def redirect_to_root_path
    flash[:error] = "Sorry, the system couldn&#8217;t find what you were looking for.".html_safe
    redirect_to root_url
  end
end
