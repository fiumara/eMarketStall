class UsersController < ApplicationController
    before_action :require_login
  
    def profile
      if session[:role] == 'acquirente'
        @user = Acquirente.find(session[:user_id])
        render 'profile_acquirente'
      elsif session[:role] == 'amministratore'
        @user = Amministratore.find(session[:user_id])
        render 'profile_amministratore'
      else
        redirect_to login_path, alert: "Tipo di utente non riconosciuto"
      end
    end
  
    private
  
    def require_login
      unless session[:user_id]
        flash[:alert] = "Devi effettuare l'accesso per accedere a questa pagina"
        redirect_to login_path
      end
    end
  end
  