require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def fake_action
      user = google_login({
        email: 'user@example.com',
        name: 'Mario Rossi',
        image: 'https://example.com/img.jpg',
        id_acquirente: '123456'
      })
      render plain: "OK - #{user.nome}"
    end
  end

  before do
    routes.draw { get 'fake_action' => 'anonymous#fake_action' }
  end

  it 'crea un nuovo utente Google se non esiste' do
    expect {
      get :fake_action
    }.to change(Acquirente, :count).by(1)

    user = Acquirente.last
    expect(user.email).to eq('user@example.com')
    expect(user.nome).to eq('Mario Rossi')
    expect(session[:user_id]).to eq(user.id)
    expect(session[:role]).to eq('acquirente')
  end

  it 'trova utente esistente se già registrato' do
    Acquirente.create!(
      email: 'user@example.com',
      nome: 'Mario',
      password: 'test123',
      telefono: '123456'
    )

    expect {
      get :fake_action
    }.not_to change(Acquirente, :count)

    expect(response.body).to include('Mario')
  end
end
