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

  def authenticate_user!
    unless logged_in?
      redirect_to login_path, alert: 'Devi effettuare il login per accedere a questa pagina'
    end
  end

  def authenticate_acquirente!
    authenticate_user!
    unless session[:role] == 'acquirente'
      redirect_to root_path, alert: 'Accesso negato: questa pagina è riservata agli acquirenti'
    end
  end

  def authenticate_amministratore!
    authenticate_user!
    unless session[:role] == 'amministratore'
      redirect_to root_path, alert: 'Accesso negato: questa pagina è riservata agli amministratori'
    end
  end
end

  