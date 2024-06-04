module SessionsHelper
    def logged_in?
      !current_user.nil?
    end
  
    def current_user
      @current_user ||= if session[:role] == 'acquirente'
                          Acquirente.find_by(id: session[:user_id])
                        elsif session[:role] == 'amministratore'
                          Amministratore.find_by(id: session[:user_id])
                        end
    end
  end
  