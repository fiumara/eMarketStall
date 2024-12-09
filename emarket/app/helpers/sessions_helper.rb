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
    redirect_to login_path, alert: 'Devi effettuare il login per accedere a questa pagina' unless logged_in?
  end

  def authenticate_acquirente!
    authenticate_user!
    redirect_to root_path, alert: 'Accesso riservato agli acquirenti' unless session[:role] == 'acquirente'
  end

  def authenticate_amministratore!
    authenticate_user!
    redirect_to root_path, alert: 'Accesso riservato agli amministratori' unless session[:role] == 'amministratore'
  end

  def unauthenticated_user?
    session[:role].nil? || session[:user_id].nil?
  end
end
