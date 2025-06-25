require 'rails_helper'
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Login tramite Google (flusso completo)', type: :system do
  before do
    driven_by(:rack_test)

    # Mock risposta token
    stub_request(:post, "https://oauth2.googleapis.com/token").to_return(
      body: { access_token: 'fake_token' }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    # Mock user info
    stub_request(:get, "https://www.googleapis.com/oauth2/v1/userinfo?access_token=fake_token").to_return(
      body: {
        email: 'test@example.com',
        name: 'Mario Rossi',
        picture: 'https://example.com/pic.jpg',
        id: '123456'
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    # ❗ Aggiunto: Mock della traduzione di Google
    stub_request(:get, %r{https://translation.googleapis.com/language/translate/v2}).to_return(
      body: '{"data":{"translations":[{"translatedText":"Benvenuto, Mario Rossi!"}]}}',
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  it 'permette all’utente di autenticarsi tramite Google' do
    visit '/auth/google_oauth2/callback?code=fake_code'

    expect(page).to have_content('Benvenuto, Mario Rossi!')
    expect(Acquirente.last.email).to eq('test@example.com')
  end
end
