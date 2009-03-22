module SessionEditingController
  
  def self.included(base)
    base.send(:include, Actions)
  end

  module Actions
    def update_session
      session[params[:key].to_sym] = params[:value]
      render :status => 200, :text => params[:value]
    end
  end
  
end
