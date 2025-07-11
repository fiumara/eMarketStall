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
    },
    {
      id: 6,
      nome: "matteo",
      cognome: "Bianchi",
      telefono: "1102334485",
      nome_utente: "matteo.bianchi",
      email: "matteo.bianchi@example.com",
      password: "password6",
      password_confirmation: "password6"
    }
  ]
)




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
    nome_negozio: "acc",
    descrizione: "accessori di vario genere",
    indirizzo: "Via Firenze 7, roma",
    email: "acc@example.com",
    telefono: "0623456789",
    acquirente_id: 3
  },
  {
    id: 4,
    nome_negozio: "Gioiellini",
    descrizione: "gioielli fatti a mano",
    indirizzo: "Via Roma 11, Milano",
    email: "gioiellini@example.com",
    telefono: "0212345778",
    acquirente_id: 4
  },
  {
    id: 5,
    nome_negozio: "salute e bene",
    descrizione: "articoli naturali per il corpo",
    indirizzo: "Via Firenze 6, Torino",
    email: "seb@example.com",
    telefono: "0228456789",
    acquirente_id: 5
  },
  {
    id: 6,
    nome_negozio: "penne e per",
    descrizione: "penne stilografiche fatte a mano",
    indirizzo: "Via Firenze 9, roma",
    email: "penne@example.com",
    telefono: "0623456759",
    acquirente_id: 6
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
    nome_prodotto: "portafoglio",
    descrizione: "portafoglio in pelle fatto a mano",
    prezzo: 50,
    quantita_disponibile: 15,
    negozio_id: 3,
    categorium_id: Categorium.find_by(nome: 'Accessori').id
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
    nome_prodotto: "sgabello",
    descrizione: "sgabello in vimini ",
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
  },
  

  {
    nome_prodotto: "collanina",
    descrizione: "collana in argento fatta a mano ",
    prezzo: 50.95,
    quantita_disponibile: 40,
    negozio_id: 4,
    categorium_id: Categorium.find_by(nome: 'Gioielli').id
  },
  
  {
    nome_prodotto: "crema viso",
    descrizione: "crema viso fatta con erbe naturali di montagna",
    prezzo: 27.99,
    quantita_disponibile: 60,
    negozio_id: 5,
    categorium_id: Categorium.find_by(nome: 'Salute e Benessere').id
  },
  {
    nome_prodotto: "penna stilografica",
    descrizione: "penna stilografica in avorio",
    prezzo: 150.99,
    quantita_disponibile: 90,
    negozio_id: 6,
    categorium_id: Categorium.find_by(nome: 'Articoli Ufficio').id
  }
])
Promozione.destroy_all

Promozione.create!([
  {
    nome: "Sconto Jeans Primavera",
    descrizione: "Sconto del 20% sui Jeans Slim Fit per la nuova stagione",
    inizio: DateTime.new(2025, 5, 1),
    fine: DateTime.new(2025, 9, 15),
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
    fine: DateTime.new(2025, 10, 20),
    sconto: 10.0,
    tipo: "categoria",
    categorium_id: Categorium.find_by(nome: 'Abbigliamento').id,
    created_by: "admin"
  }
  
])
Faq.destroy_all

Faq.create!([
  {
    domanda: "Come posso registrarmi come acquirente?",
    risposta: "Clicca su 'Registrati' nella home page e compila il modulo con i tuoi dati personali. Riceverai un'email di conferma."
  },
  {
    domanda: "Posso aprire un negozio sul sito?",
    risposta: "Sì, dopo esserti registrato come acquirente, puoi aprire un negozio accedendo alla tua area personale e cliccando su 'Crea un negozio'."
  },
  {
    domanda: "Come funziona il sistema di promozioni?",
    risposta: "I venditori e gli amministratori possono creare promozioni applicabili a singoli prodotti o a intere categorie. Gli sconti vengono applicati automaticamente se validi."
  },
  {
    domanda: "Cosa succede se il prodotto acquistato non è disponibile?",
    risposta: "Nel caso un prodotto non sia disponibile, riceverai un rimborso completo oppure potrai scegliere un prodotto alternativo se disponibile."
  },
  {
    domanda: "Come faccio a contattare il venditore?",
    risposta: "Puoi contattare il venditore dalla pagina del negozio cliccando su 'Contatta il venditore', se abilitato."
  },
  {
    domanda: "Come segnalo un comportamento scorretto di un venditore?",
    risposta: "Puoi segnalare un negozio cliccando su 'Segnala negozio' nella pagina del venditore. L'amministratore esaminerà la tua segnalazione."
  },
  {
    domanda: "Come posso modificare i miei dati personali?",
    risposta: "Accedi al tuo profilo e clicca su 'Modifica profilo' per aggiornare le informazioni personali e le credenziali."
  },
  {
    domanda: "Posso eliminare il mio account?",
    risposta: "Sì, puoi richiedere la cancellazione del tuo account dalle impostazioni del profilo. I tuoi negozi e prodotti saranno rimossi."
  },
  {
    domanda: "Come vengono calcolati gli sconti se ci sono più promozioni?",
    risposta: "Se più promozioni sono applicabili a un prodotto, verrà applicato automaticamente lo sconto più vantaggioso per l'utente."
  },
  {
    domanda: "Chi può vedere le mie informazioni personali?",
    risposta: "Solo tu e, in alcuni casi, gli amministratori possono visualizzare le informazioni personali. Se imposti il tuo profilo come privato, gli altri utenti non vedranno i tuoi dati."
  }
])

puts "FAQ caricate con successo!"







puts "Seed completato con successo!"




