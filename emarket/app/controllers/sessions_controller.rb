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
      redirect_to profile_path(user), notice: "Accesso effettuato!"
    else
      flash.now[:alert] = "Email o password non validi"
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
    
    # Trova o crea l'utente in base al ruolo
    user = Acquirente.find_or_create_by(email: email) do |u|
      u.nome = user_info['info']['name']
      # Aggiungi altre proprietà necessarie

      Rails.logger.info("Auth Hash: #{request.env['omniauth.auth'].inspect}")
  Rails.logger.info("Error: #{request.env['omniauth.error']}")
  # Logica di autenticazione
rescue StandardError => e
  Rails.logger.error("Errore durante l'autenticazione: #{e.message}")
  redirect_to root_path, alert: "Errore di autenticazione"
    end
  
    session[:user_id] = user.id
    session[:role] = 'acquirente' # Definisci il ruolo
    redirect_to profile_path(user), notice: 'Login effettuato con successo'
  rescue StandardError => e
    redirect_to root_path, alert: "Errore: #{e.message}"
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
