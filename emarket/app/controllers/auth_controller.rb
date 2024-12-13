
require 'net/http'
require 'uri'
require 'json'

class AuthController < ApplicationController
  def google
    redirect_to "https://accounts.google.com/o/oauth2/auth?client_id=#{ENV['GOOGLE_CLIENT_ID']}&redirect_uri=#{callback_url}&response_type=code&scope=email%20profile"
  end

  def callback
    
    code = params[:code]
    if code.blank?
      redirect_to root_path, alert: 'Errore durante l’autenticazione con Google.'
      return
    end

    # Ottieni il token di accesso
    token_response = fetch_access_token(code)
    access_token = token_response['access_token']

    if access_token.blank?
      redirect_to root_path, alert: 'Impossibile ottenere il token di accesso.'
      return
    end

    # Ottieni i dati dell'utente
    user_info = fetch_user_info(access_token)
    acquirente = google_login({
      email: user_info['email'],
      nome: user_info['name'],
      image: user_info['picture'],
      id_acquirente: user_info['id']
    })

    redirect_to root_path, notice: "Benvenuto, #{acquirente.nome}!"
  end 

  def failure
    redirect_to root_path, alert: 'Accesso non riuscito tramite Google.'
  end
  
  private

  def callback_url
    "#{request.base_url}/auth/google_oauth2/callback"
  end
  

  def fetch_access_token(code)
    uri = URI('https://oauth2.googleapis.com/token')
    response = Net::HTTP.post_form(uri, {
      code: code,
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      redirect_uri: callback_url,
      grant_type: 'authorization_code'
    })
    JSON.parse(response.body)
  end
  
  def fetch_user_info(access_token)
    uri = URI("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{access_token}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
  
end
