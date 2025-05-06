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
    },
    {
      id: 4,
      nome: "Lara",
      cognome: "Bianchi",
      telefono: "1192334455",
      nome_utente: "lara.bianchi",
      email: "lara.bianchi@example.com",
      password: "password4",
      password_confirmation: "password4"
    },
    {
      id: 5,
      nome: "Paolo",
      cognome: "Bianchi",
      telefono: "1102334455",
      nome_utente: "paolo.bianchi",
      email: "paolo.bianchi@example.com",
      password: "password5",
      password_confirmation: "password5"
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

Categorium.destroy_all
# Creazione delle categorie
Categorium.create(nome: 'Gioielli')
Categorium.create(nome: 'Accessori')
Categorium.create(nome: 'Abbigliamento')
Categorium.create(nome: 'Casa')
Categorium.create(nome: 'Articoli Ufficio')
Categorium.create(nome: 'Salute e Benessere')

Negozio.destroy_all

Negozio.create!([
  {
    id: 1,
    nome_negozio: "Fashion Store",
    descrizione: "Abbigliamento alla moda per tutte le età",
    indirizzo: "Via Roma 10, Milano",
    email: "fashion@example.com",
    telefono: "0212345678",
    acquirente_id: 1
  },
  {
    id: 2,
    nome_negozio: "Casa&Co",
    descrizione: "Accessori e decorazioni per la casa",
    indirizzo: "Via Firenze 5, Torino",
    email: "casaco@example.com",
    telefono: "0223456789",
    acquirente_id: 2
  },
  {
    id: 3,
    nome_negozio: "ceramica",
    descrizione: "ceramiche  per la casa",
    indirizzo: "Via Firenze 7, roma",
    email: "ceramiche@example.com",
    telefono: "0623456789",
    acquirente_id: 3
  }
])

Prodotto.destroy_all

Prodotto.create!([
  {
    nome_prodotto: "Maglietta Bianca",
    descrizione: "Maglietta in cotone 100%, taglia unica",
    prezzo: 15.99,
    quantita_disponibile: 100,
    negozio_id: 1,
    categorium_id: Categorium.find_by(nome: 'Abbigliamento').id
  },
  {
    nome_prodotto: "Candela Profumata",
    descrizione: "Candela aromatica alla vaniglia",
    prezzo: 8.50,
    quantita_disponibile: 50,
    negozio_id: 2,
    categorium_id: Categorium.find_by(nome: 'Casa').id
  },
  {
    nome_prodotto: "vaso",
    descrizione: "vaso in ceramica fatto a mano",
    prezzo: 8,
    quantita_disponibile: 7,
    negozio_id: 3,
    categorium_id: Categorium.find_by(nome: 'Casa').id
  },
  {
    nome_prodotto: "Jeans Slim Fit",
    descrizione: "Jeans in denim elasticizzato, taglio slim",
    prezzo: 39.99,
    quantita_disponibile: 50,
    negozio_id: 1,
    categorium_id: Categorium.find_by(nome: 'Abbigliamento').id
  },
  {
    nome_prodotto: "sedia",
    descrizione: "sedia in vimini ",
    prezzo: 24.90,
    quantita_disponibile: 30,
    negozio_id: 2,
    categorium_id: Categorium.find_by(nome: 'Casa').id
  },
  

  {
    nome_prodotto: "poltrona",
    descrizione: "poltrona fatta a mano ",
    prezzo: 29.95,
    quantita_disponibile: 40,
    negozio_id: 2,
    categorium_id: Categorium.find_by(nome: 'Casa').id
  },
  
  {
    nome_prodotto: "Felpa con Cappuccio",
    descrizione: "Felpa in tessuto misto, comoda e calda, taglie assortite",
    prezzo: 27.99,
    quantita_disponibile: 60,
    negozio_id: 1,
    categorium_id: Categorium.find_by(nome: 'Abbigliamento').id
  },
  {
    nome_prodotto: "Cornice in Legno Naturale",
    descrizione: "Cornice 30x40 cm, perfetta per foto o poster",
    prezzo: 12.99,
    quantita_disponibile: 90,
    negozio_id: 2,
    categorium_id: Categorium.find_by(nome: 'Casa').id
  }
])
Promozione.destroy_all

Promozione.create!([
  {
    nome: "Sconto Jeans Primavera",
    descrizione: "Sconto del 20% sui Jeans Slim Fit per la nuova stagione",
    inizio: DateTime.new(2025, 5, 1),
    fine: DateTime.new(2025, 5, 15),
    sconto: 20.0,
    tipo: "singolo_prodotto",
    prodotto_id: Prodotto.find_by(nome_prodotto: "Jeans Slim Fit").id,
    negozio_id: 1,
    created_by: "negozio"
  },
  {
    nome: "Promo Abbigliamento -10%",
    descrizione: "Sconto del 10% su tutta la categoria Abbigliamento",
    inizio: DateTime.new(2025, 5, 3),
    fine: DateTime.new(2025, 5, 20),
    sconto: 10.0,
    tipo: "categoria",
    categorium_id: Categorium.find_by(nome: 'Abbigliamento').id,
    created_by: "admin"
  },
  {
    nome: "vaso",
    descrizione: "5€ di sconto sul vaso in ceramica",
    inizio: DateTime.new(2025, 5, 1),
    fine: DateTime.new(2025, 5, 13),
    sconto: 5.0,
    tipo: "singolo_prodotto",
    prodotto_id: Prodotto.find_by(nome_prodotto: "vaso").id,
    negozio_id: 3,
    created_by: "negozio"
  }
  
])







puts "Seed completato con successo!"




