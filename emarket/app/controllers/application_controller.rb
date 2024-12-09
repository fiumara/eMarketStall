class ApplicationController < ActionController::Base
    include SessionsHelper
    
    # Questo filtro protegge le azioni che richiedono un utente autenticato
    before_action :set_current_user
  
    private
  
    # Imposta l'utente corrente in base alla sessione
    def set_current_user
      @current_user = current_user
    end
  
    # Metodo per integrare Google OAuth
    def google_login(auth)
      # I dati sembrano essere direttamente disponibili
      user_info = {
        email: auth[:email],
        nome: auth[:name],
        image_url: auth[:image],
        id_acquirente: auth[:id_acquirente]
      }
    
      # Trova o crea l'utente nel database
      user = Acquirente.find_or_create_by(email: user_info[:email]) do |new_user|
        new_user.nome = user_info[:nome]
        new_user.telefono = user_info[:id_acquirente] # Ad esempio, puoi usare id_acquirente come telefono o gestirlo diversamente
        new_user.nome_utente = user_info[:nome].parameterize if user_info[:nome] # Genera un nome utente
      end
    
      # Salva l'utente nella sessione
      session[:user_id] = user.id
      session[:role] = 'acquirente'
    
      user
    end
  
    # Gestione di utenti non autenticati
    def authenticate_user_with_google
      redirect_to login_path, alert: 'Devi effettuare il login con Google per accedere.' unless logged_in?
    end
    protect_from_forgery with: :exception, unless: -> { request.path.start_with?('/auth/') }
    
  end
  
  