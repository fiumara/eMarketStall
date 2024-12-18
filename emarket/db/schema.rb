# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_12_16_170411) do

  create_table "acquirentes", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "nome"
    t.string "cognome"
    t.string "telefono"
    t.string "nome_utente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "id_acquirente"
    t.string "image_url"
  end

  create_table "amministratores", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "nome"
    t.string "cognome"
    t.string "telefono"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "carrello_items", force: :cascade do |t|
    t.integer "carrello_id", null: false
    t.integer "prodotto_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrello_id"], name: "index_carrello_items_on_carrello_id"
    t.index ["prodotto_id"], name: "index_carrello_items_on_prodotto_id"
  end

  create_table "carrellos", force: :cascade do |t|
    t.integer "acquirente_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acquirente_id"], name: "index_carrellos_on_acquirente_id"
  end

  create_table "categoria", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.string "nome"
    t.string "mittente_type", null: false
    t.integer "mittente_id", null: false
    t.string "destinatario_type", null: false
    t.integer "destinatario_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destinatario_type", "destinatario_id"], name: "index_chat_rooms_on_destinatario"
    t.index ["mittente_type", "mittente_id"], name: "index_chat_rooms_on_mittente"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "domanda"
    t.string "risposta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messaggi", force: :cascade do |t|
    t.text "contenuto"
    t.integer "chat_room_id", null: false
    t.string "mittente_type", null: false
    t.integer "mittente_id", null: false
    t.string "destinatario_type", null: false
    t.integer "destinatario_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_room_id"], name: "index_messaggi_on_chat_room_id"
    t.index ["destinatario_type", "destinatario_id"], name: "index_messaggi_on_destinatario"
    t.index ["mittente_type", "mittente_id"], name: "index_messaggi_on_mittente"
  end

  create_table "negozios", force: :cascade do |t|
    t.string "nome_negozio"
    t.string "descrizione"
    t.string "indirizzo"
    t.string "email"
    t.string "telefono"
    t.integer "acquirente_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acquirente_id"], name: "index_negozios_on_acquirente_id"
  end

  create_table "prodottos", force: :cascade do |t|
    t.string "nome_prodotto"
    t.string "descrizione"
    t.float "prezzo"
    t.integer "negozio_id", null: false
    t.integer "categorium_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["categorium_id"], name: "index_prodottos_on_categorium_id"
    t.index ["negozio_id"], name: "index_prodottos_on_negozio_id"
  end

  create_table "promoziones", force: :cascade do |t|
    t.string "nome"
    t.text "descrizione"
    t.datetime "inizio"
    t.datetime "fine"
    t.decimal "sconto"
    t.string "tipo"
    t.integer "prodotto_id"
    t.integer "categorium_id"
    t.integer "negozio_id"
    t.string "created_by", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["categorium_id"], name: "index_promoziones_on_categorium_id"
    t.index ["negozio_id"], name: "index_promoziones_on_negozio_id"
    t.index ["prodotto_id"], name: "index_promoziones_on_prodotto_id"
  end

  create_table "recensiones", force: :cascade do |t|
  end

  create_table "resos", force: :cascade do |t|
    t.string "nome_prodotto"
    t.string "nome_acquirente"
    t.string "id_ordine"
    t.text "motivazione_reso"
    t.date "data_reso"
    t.string "stato"
    t.text "note_acquirente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "statisticas", force: :cascade do |t|
    t.integer "prodotto_id", null: false
    t.integer "visualizzazioni"
    t.integer "vendite"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prodotto_id"], name: "index_statisticas_on_prodotto_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "variantis", force: :cascade do |t|
    t.integer "prodotto_id", null: false
    t.string "taglia"
    t.string "colore"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prodotto_id"], name: "index_variantis_on_prodotto_id"
  end

  create_table "wishlist_items", force: :cascade do |t|
    t.integer "acquirente_id", null: false
    t.integer "prodotto_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acquirente_id", "prodotto_id"], name: "index_wishlist_items_on_acquirente_id_and_prodotto_id", unique: true
    t.index ["acquirente_id"], name: "index_wishlist_items_on_acquirente_id"
    t.index ["prodotto_id"], name: "index_wishlist_items_on_prodotto_id"
  end

  add_foreign_key "carrello_items", "carrellos"
  add_foreign_key "carrello_items", "prodottos"
  add_foreign_key "carrellos", "acquirentes"
  add_foreign_key "messaggi", "chat_rooms"
  add_foreign_key "negozios", "acquirentes"
  add_foreign_key "prodottos", "categoria"
  add_foreign_key "prodottos", "negozios"
  add_foreign_key "promoziones", "categoria"
  add_foreign_key "promoziones", "negozios"
  add_foreign_key "promoziones", "prodottos"
  add_foreign_key "statisticas", "prodottos"
  add_foreign_key "variantis", "prodottos"
  add_foreign_key "wishlist_items", "acquirentes"
  add_foreign_key "wishlist_items", "prodottos"
end
