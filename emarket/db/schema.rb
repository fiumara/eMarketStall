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

ActiveRecord::Schema.define(version: 2024_05_29_150350) do

  create_table "acquirentes", force: :cascade do |t|
    t.string "nome"
    t.string "cognome"
    t.string "telefono"
    t.string "nome_utente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "amministratores", force: :cascade do |t|
    t.string "nome"
    t.string "cognome"
    t.string "telefono"
    t.integer "id_amministratore"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

# Could not dump table "negozios" because of following StandardError
#   Unknown type 'uuid' for column 'id'

# Could not dump table "prodottos" because of following StandardError
#   Unknown type 'uuid' for column 'id'

# Could not dump table "recensiones" because of following StandardError
#   Unknown type 'uuid' for column 'id'

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
