# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150716205215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "language_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "roles_count",         default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "conjugations", force: :cascade do |t|
    t.string   "example_english"
    t.string   "gerund"
    t.string   "gerund_english"
    t.string   "pastparticiple"
    t.string   "pastparticiple_english"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "conjugation"
    t.integer  "verb_id"
    t.integer  "tense_id"
    t.integer  "form_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.integer  "classroom_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "forms", force: :cascade do |t|
    t.integer  "language_id"
    t.string   "form"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "conjugation_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.string   "message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "role"
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "classroom_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "role"
  end

  create_table "tenses", force: :cascade do |t|
    t.string   "combined_tense"
    t.string   "combined_tense_english"
    t.string   "mood"
    t.string   "mood_english"
    t.string   "tense"
    t.string   "tense_english"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "access_token"
  end

  create_table "verbs", force: :cascade do |t|
    t.string   "verb"
    t.string   "verb_english"
    t.integer  "language_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
