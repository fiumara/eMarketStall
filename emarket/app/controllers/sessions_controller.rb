class SessionsController < ApplicationController
  def new
  end

  def create
    user = if params[:role] == 'acquirente'
             Acquirente.find_by(email: params[:email])
           elsif params[:role] == 'amministratore'
             Amministratore.find_by(email: params[:email])
           end
  
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:role] = params[:role]
      redirect_to profile_path(user), notice: "Accesso effettuato con successo!"
    elsif user && user.password_digest.blank?
      flash.now[:alert] = "Questo account è stato creato tramite Google. Usa il login con Google per accedere."
      render :new
    else
      flash.now[:alert] = "Email o password non validi."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path, notice: "Disconnessione effettuata!"
  end

  def failure
    redirect_to root_path, alert: "Errore di autenticazione: #{params[:message]}"
  end

  def google_auth
    user_info = request.env['omniauth.auth']
    email = user_info['info']['email']
    
    user = Acquirente.find_or_create_by(email: email) do |u|
      u.nome = user_info['info']['first_name']
      u.cognome = user_info['info']['last_name']
      u.password = SecureRandom.hex(10) # Password casuale per compatibilità con has_secure_password
      u.id_acquirente = user_info['uid']
      u.image_url = user_info['info']['image']
    end
  
    session[:user_id] = user.id
    session[:role] = 'acquirente'
    redirect_to profile_path(user), notice: 'Login effettuato con successo tramite Google!'
  rescue StandardError => e
    redirect_to root_path, alert: "Errore durante l'autenticazione: #{e.message}"
  end


  private

  def profile_path(user)
    if user.is_a?(Acquirente)
      acquirente_path(user)
    elsif user.is_a?(Amministratore)
      amministratore_path(user)
    else
      root_path
    end
  end
end
