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


# Creazione delle categorie
Categorium.create(nome: 'Gioielli')
Categorium.create(nome: 'Accessori')
Categorium.create(nome: 'Abbigliamento')
Categorium.create(nome: 'Casa')
Categorium.create(nome: 'Articoli Ufficio')
Categorium.create(nome: 'Salute e Benessere')

stores = [
  { name: "Luxury Gems", address: "Via Montenapoleone 1, Milano", email: "info@luxurygems.it" },
  { name: "Fashion Boutique", address: "Corso Vittorio Emanuele 20, Roma", email: "info@fashionboutique.it" },
  { name: "Home Elegance", address: "Piazza della Repubblica 15, Firenze", email: "info@homeelegance.it" },
  { name: "Office Supplies", address: "Via dei Mercanti 30, Torino", email: "info@officesupplies.it" },
  { name: "Wellness Point", address: "Viale della Salute 8, Bologna", email: "info@wellnesspoint.it" },
  { name: "Trendy Accessories", address: "Via Garibaldi 12, Venezia", email: "info@trendyaccessories.it" },
  { name: "Chic Wear", address: "Piazza San Marco 22, Napoli", email: "info@chicwear.it" },
  { name: "Cozy Home", address: "Via Roma 5, Palermo", email: "info@cozyhome.it" },
  { name: "Smart Office", address: "Corso Italia 18, Genova", email: "info@smartoffice.it" },
  { name: "Holistic Life", address: "Viale Tranquillità 10, Bari", email: "info@holisticlife.it" }
]

negozios.each do |negozio|
  Negozio.create!(negozio)
end

# Creazione prodotti per ogni categoria
products = {
  "Gioielli" => ["Anello Diamante", "Collana Oro", "Bracciale Argento", "Orecchini Perle", "Orologio Lusso", "Ciondolo Rubino", "Anello Smeraldo", "Collana Zaffiro", "Bracciale Swarovski", "Orecchini Diamante"],
  "Accessori" => ["Borsa Pelle", "Portafoglio Uomo", "Cintura Elegante", "Cappello Panama", "Sciarpa Cashmere", "Occhiali da Sole", "Zaino in Pelle", "Guanti Invernali", "Portachiavi Designer", "Ombrello Automatico"],
  "Abbigliamento" => ["T-shirt Cotone", "Jeans Slim Fit", "Giacca Elegante", "Scarpe Running", "Felpa Hoodie", "Cappotto Lana", "Sneakers Casual", "Maglia Termica", "Pantaloni Sportivi", "Vestito Elegante"],
  "Casa" => ["Set di Lenzuola", "Tappeto Persiano", "Lampada da Tavolo", "Servizio Piatti", "Poltrona Relax", "Cuscini Decorativi", "Quadro Moderno", "Aspirapolvere Robot", "Macchina Caffè", "Vaso in Ceramica"],
  "Articoli Ufficio" => ["Penna Stilografica", "Notebook in Pelle", "Sedia Ergonomica", "Scrivania in Legno", "Organizer da Tavolo", "Stampante Laser", "Mouse Wireless", "Tastiera Meccanica", "Cuffie con Microfono", "Zaino Porta PC"],
  "Salute e Benessere" => ["Olio Essenziale Lavanda", "Integratore Multivitaminico", "Crema Idratante", "Tisana Detox", "Maschera Viso Bio", "Pesa Digitale", "Tappetino Yoga", "Profumo Naturale", "Cuscino Ortopedico", "Lampada di Sale"]
}

prodottos.each do |category, prodotto_names|
  prodotto_names.each do |name|
    Prodotto.create!(
      name: name,
      description: "Descrizione di #{name}",
      price: rand(10..500),
      stock: rand(10..100),
      category: category,
      store_id: Store.pluck(:id).sample # Assegna a un negozio a caso
    )
  end
end

puts "Seed completato con successo!"




