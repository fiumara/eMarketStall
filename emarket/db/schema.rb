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

ActiveRecord::Schema.define(version: 2024_06_18_155846) do

  create_table "acquirentes", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "nome"
    t.string "cognome"
    t.string "telefono"
    t.string "nome_utente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "messages", force: :cascade do |t|
    t.string "nome_utente"
    t.string "tipo_utente"
    t.text "contenuto"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messaggios", force: :cascade do |t|
    t.string "nome_utente"
    t.string "tipo_utente"
    t.text "contenuto"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "negozios", force: :cascade do |t|
    t.string "nome_negozio"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["negozio_id"], name: "index_prodottos_on_negozio_id"
  end

  create_table "recensiones", force: :cascade do |t|
  end

  create_table "variantis", force: :cascade do |t|
    t.integer "prodotto_id", null: false
    t.string "taglia"
    t.string "colore"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prodotto_id"], name: "index_variantis_on_prodotto_id"
  end

  add_foreign_key "negozios", "acquirentes"
  add_foreign_key "prodottos", "negozios"
  add_foreign_key "variantis", "prodottos"
end
