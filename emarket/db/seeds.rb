# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#prodottos = Prodotto.create ([{id: 1}, { nome_prodotto: 'Maglietta'}, {descrizione: 'Maglietta bianca'}, {prezzo: 5}])
#Prodotto.create(id: 1, prodotto: prodottos.first)

#acquirentes = Acquirente.create ([{id: 1}, { nome: 'Maria'}, {cognome: 'Rossi'}, {telefono: '1234'}, {nome_utente: 'MRossi'}, {email:'maria.rossi@example.it'}, {password: 'password1'}, {password_confirmation: 'password1'}])
#Acquirente.create(id: 1, acquirente: acquirentes.first)

# db/seeds.rb

# Cancella tutti i record esistenti nella tabella 'acquirentes'
Acquirente.destroy_all

# Crea nuovi record di esempio
Acquirente.create!(
  [
    {
      id: 1,
      nome: "Mario",
      cognome: "Rossi",
      telefono: "1234567890",
      nome_utente: "mario.rossi",
      email: "mario.rossi@example.com",
      password: "password1",
      password_confirmation: "password1"
    },
    {
      id: 2,
      nome: "Luigi",
      cognome: "Verdi",
      telefono: "0987654321",
      nome_utente: "luigi.verdi",
      email: "luigi.verdi@example.com",
      password: "password2",
      password_confirmation: "password2"
    },
    {
      id: 3,
      nome: "Anna",
      cognome: "Bianchi",
      telefono: "1122334455",
      nome_utente: "anna.bianchi",
      email: "anna.bianchi@example.com",
      password: "password3",
      password_confirmation: "password3"
    }
  ]
)


# db/seeds.rb

# Cancella tutti i record esistenti nella tabella 'amministratores'
Amministratore.destroy_all

# Crea nuovi record di esempio
Amministratore.create!(
  [
    {
      id: 1,
      nome: "Giovanni",
      cognome: "Neri",
      telefono: "3334445556",
      email: "giovanni.neri@example.com",
      password: "adminpass1",
      password_confirmation: "adminpass1"
    },
    {
      id: 2,
      nome: "Marta",
      cognome: "Rossi",
      telefono: "3344455566",
      email: "marta.rossi@example.com",
      password: "adminpass2",
      password_confirmation: "adminpass2"
    },
    {
      id: 3,
      nome: "Luca",
      cognome: "Bianchi",
      telefono: "3354465577",
      email: "luca.bianchi@example.com",
      password: "adminpass3",
      password_confirmation: "adminpass3"
    }
  ]
)

#crea record di messaggi esempio

Messaggio.create(nome_utente: 'Utente1', tipo_utente: 'Acquirente', contenuto: 'Contenuto del messaggio 1')
Messaggio.create(nome_utente: 'Utente2', tipo_utente: 'Negozio', contenuto: 'Contenuto del messaggio 2')
