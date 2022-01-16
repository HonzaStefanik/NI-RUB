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

ActiveRecord::Schema.define(version: 5) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer", force: :cascade do |t|
    t.text "answer"
    t.boolean "correct"
  end

  create_table "app_user", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "salt"
  end

  create_table "category", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "question", force: :cascade do |t|
    t.text "question"
  end

  create_table "quiz", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

end
