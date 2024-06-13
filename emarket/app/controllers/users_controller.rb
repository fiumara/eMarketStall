class UsersController < ApplicationController
  before_action :require_login, only: [:profile]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'Utente registrato con successo.'
    else
      render :new
    end
  end

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

  def user_params
    params.require(:user).permit(:nome, :cognome, :nome_utente, :telefono, :email, :password, :password_confirmation, :indirizzo, :profilo_privato)
  end
end

  