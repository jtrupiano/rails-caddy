module SessionEditingController

  def update_session
    if params[:id].nil?
      render :status => 422, :text => "Invalid request.  No session variable provided."
      return false
    end      
    session[params[:id].to_sym] = params[:value]
    render :status => 200, :text => params[:value]
  end
  
  def remove_session
    if params[:id].nil? || session[params[:id]].nil?
      render :status => 422, :text => "Invalid request.  Session variable is either missing or invalid."
      return false
    end      
    session[params[:id].to_sym] = nil
    render :status => 200, :nothing => true
  end

end
