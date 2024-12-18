module SessionsHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= begin
      user = if session[:role] == 'acquirente'
               Acquirente.find_by(id: session[:user_id])
             elsif session[:role] == 'amministratore'
               Amministratore.find_by(id: session[:user_id])
             end
      user.create_carrello if user.is_a?(Acquirente) && user.carrello.nil?
      user
    end
  end
  

  def authenticate_user!
    unless logged_in?
      redirect_to login_path, alert: 'Devi effettuare il login per accedere a questa pagina' and return
    end
  end
  

  def authenticate_acquirente!
    return unless authenticate_user! # Esce se `authenticate_user!` esegue un redirect
    unless session[:role] == 'acquirente'
      redirect_to root_path, alert: 'Accesso riservato agli acquirenti' and return
    end
  end
  
  

  def authenticate_amministratore!
    authenticate_user! # Controlla se l'utente è autenticato
    unless session[:role] == 'amministratore'
      redirect_to root_path, alert: 'Accesso riservato agli amministratori' and return
    end
  end

  def unauthenticated_user?
    session[:role].nil? || session[:user_id].nil?
  end
end
