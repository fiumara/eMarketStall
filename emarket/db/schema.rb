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

ActiveRecord::Schema.define(version: 2025_05_08_162655) do

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
    t.boolean "bloccato", default: false
    t.boolean "privato"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
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
    t.integer "carrello_id"
    t.integer "prodotto_id", null: false
    t.integer "ordine_id"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrello_id"], name: "index_carrello_items_on_carrello_id"
    t.index ["ordine_id"], name: "index_carrello_items_on_ordine_id"
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

  create_table "cronologia_ricercas", force: :cascade do |t|
    t.integer "acquirente_id", null: false
    t.integer "prodotto_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acquirente_id"], name: "index_cronologia_ricercas_on_acquirente_id"
    t.index ["prodotto_id"], name: "index_cronologia_ricercas_on_prodotto_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "domanda"
    t.string "risposta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "acquirente_id", null: false
    t.integer "prodotto_id", null: false
    t.integer "ordine_item_id", null: false
    t.integer "voto"
    t.text "nota"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "segnalato", default: false
    t.index ["acquirente_id"], name: "index_feedbacks_on_acquirente_id"
    t.index ["ordine_item_id"], name: "index_feedbacks_on_ordine_item_id"
    t.index ["prodotto_id"], name: "index_feedbacks_on_prodotto_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "acquirente_id", null: false
    t.integer "negozio_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acquirente_id"], name: "index_follows_on_acquirente_id"
    t.index ["negozio_id"], name: "index_follows_on_negozio_id"
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

  create_table "ordine_items", force: :cascade do |t|
    t.integer "ordine_id", null: false
    t.integer "prodotto_id"
    t.integer "quantity", null: false
    t.decimal "prezzo", precision: 10, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nome_prodotto"
    t.index ["ordine_id"], name: "index_ordine_items_on_ordine_id"
    t.index ["prodotto_id"], name: "index_ordine_items_on_prodotto_id"
  end

  create_table "ordini", force: :cascade do |t|
    t.integer "acquirente_id", null: false
    t.string "codice_ordine", null: false
    t.decimal "totale"
    t.string "stato"
    t.string "indirizzo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "negozio_id"
    t.index ["acquirente_id"], name: "index_ordini_on_acquirente_id"
    t.index ["codice_ordine"], name: "index_ordini_on_codice_ordine", unique: true
    t.index ["negozio_id"], name: "index_ordini_on_negozio_id"
  end

  create_table "prodottos", force: :cascade do |t|
    t.string "nome_prodotto"
    t.string "descrizione"
    t.float "prezzo"
    t.integer "quantita_disponibile", default: 0, null: false
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

  create_table "return_items", force: :cascade do |t|
    t.integer "return_request_id", null: false
    t.integer "prodotto_id", null: false
    t.integer "ordine_item_id", null: false
    t.integer "quantita", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ordine_item_id"], name: "index_return_items_on_ordine_item_id"
    t.index ["prodotto_id"], name: "index_return_items_on_prodotto_id"
    t.index ["return_request_id"], name: "index_return_items_on_return_request_id"
  end

  create_table "return_requests", force: :cascade do |t|
    t.integer "ordine_id", null: false
    t.integer "acquirente_id", null: false
    t.string "motivo"
    t.integer "stato", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["acquirente_id"], name: "index_return_requests_on_acquirente_id"
    t.index ["ordine_id"], name: "index_return_requests_on_ordine_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carrello_items", "carrellos", on_delete: :cascade
  add_foreign_key "carrello_items", "ordini", on_delete: :cascade
  add_foreign_key "carrello_items", "prodottos", on_delete: :cascade
  add_foreign_key "carrellos", "acquirentes", on_delete: :cascade
  add_foreign_key "cronologia_ricercas", "acquirentes"
  add_foreign_key "cronologia_ricercas", "prodottos"
  add_foreign_key "feedbacks", "acquirentes", on_delete: :nullify
  add_foreign_key "feedbacks", "ordine_items", on_delete: :cascade
  add_foreign_key "feedbacks", "prodottos", on_delete: :cascade
  add_foreign_key "follows", "acquirentes", on_delete: :cascade
  add_foreign_key "follows", "negozios", on_delete: :cascade
  add_foreign_key "messaggi", "chat_rooms", on_delete: :cascade
  add_foreign_key "negozios", "acquirentes"
  add_foreign_key "ordine_items", "ordini"
  add_foreign_key "ordine_items", "prodottos", on_delete: :nullify
  add_foreign_key "ordini", "acquirentes", on_delete: :cascade
  add_foreign_key "ordini", "negozios", on_delete: :nullify
  add_foreign_key "prodottos", "categoria", on_delete: :cascade
  add_foreign_key "prodottos", "negozios", on_delete: :cascade
  add_foreign_key "promoziones", "categoria", on_delete: :cascade
  add_foreign_key "promoziones", "negozios", on_delete: :cascade
  add_foreign_key "promoziones", "prodottos", on_delete: :cascade
  add_foreign_key "return_items", "ordine_items"
  add_foreign_key "return_items", "prodottos", on_delete: :cascade
  add_foreign_key "return_items", "return_requests"
  add_foreign_key "return_requests", "acquirentes", on_delete: :nullify
  add_foreign_key "return_requests", "ordini"
  add_foreign_key "statisticas", "prodottos", on_delete: :cascade
  add_foreign_key "variantis", "prodottos", on_delete: :cascade
  add_foreign_key "wishlist_items", "acquirentes", on_delete: :cascade
  add_foreign_key "wishlist_items", "prodottos", on_delete: :cascade
end
