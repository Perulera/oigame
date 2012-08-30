class ApplicationController < ActionController::Base
  
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  # Método para decirle a Varnish qué tiene que cachear
  def set_http_cache(period, visibility = false)
    expires_in period, :public => visibility, 'max-stale' => 0
  end

  # Muestra el layout nuevo o el antiguo según params[:v]
  def set_layout
    if params[:v] == 'old'
      'application'
    else
      'newdesign'
    end
  end
end
