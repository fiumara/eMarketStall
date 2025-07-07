require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'AuthController', type: :request do
  before do
    # token Google
    stub_request(:post, "https://oauth2.googleapis.com/token").to_return(
      body: { access_token: 'fake_token' }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    # dati utente Google
    stub_request(:get, "https://www.googleapis.com/oauth2/v1/userinfo?access_token=fake_token").to_return(
      body: {
        email: 'test@example.com',
        name: 'Mario Rossi',
        picture: 'https://example.com/pic.jpg',
        id: '123456'
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    # traduzione (Google Translate)
    stub_request(:get, %r{https://translation.googleapis.com/language/translate/v2}).to_return(
      body: '{"data":{"translations":[{"translatedText":"Benvenuto, Mario Rossi!"}]}}',
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  it 'gestisce correttamente il login tramite callback' do
    get '/auth/google_oauth2/callback', params: { code: 'fake_code' }
    follow_redirect!

    expect(response.body).to include('Benvenuto, Mario Rossi')
    expect(Acquirente.find_by(email: 'test@example.com')).not_to be_nil
  end

  it 'reindirizza se manca il code' do
    get '/auth/google_oauth2/callback'
    follow_redirect!

    expect(flash[:alert]).to eq('Errore durante l’autenticazione con Google.')
  end
end
