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

ActiveRecord::Schema[7.0].define(version: 2023_06_04_213942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "assessments", force: :cascade do |t|
    t.string "assessmentable_type", null: false
    t.bigint "assessmentable_id", null: false
    t.string "author_type", null: false
    t.bigint "author_id", null: false
    t.integer "item_a_assessment", default: 1, null: false
    t.text "item_a_comment", default: "", null: false
    t.integer "item_b_assessment", default: 1, null: false
    t.text "item_b_comment", default: "", null: false
    t.integer "item_c_assessment", default: 1, null: false
    t.text "item_c_comment", default: "", null: false
    t.integer "item_d_assessment", default: 1, null: false
    t.text "item_d_comment", default: "", null: false
    t.text "general_comments", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessmentable_type", "assessmentable_id"], name: "index_assessments_on_assessmentable"
    t.index ["author_type", "author_id"], name: "index_assessments_on_author"
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "meeting_id", null: false
    t.integer "status", default: 0, null: false
    t.text "reason", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_attendances_on_meeting_id"
    t.index ["person_id", "meeting_id"], name: "index_attendances_on_person_id_and_meeting_id", unique: true
    t.index ["person_id"], name: "index_attendances_on_person_id"
  end

  create_table "axes", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clusters", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.integer "week_day", null: false
    t.string "address"
    t.integer "modality", null: false
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_clusters_on_person_id"
  end

  create_table "clusters_teams", id: false, force: :cascade do |t|
    t.bigint "cluster_id", null: false
    t.bigint "team_id", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "cnpj", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events_people", id: false, force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "person_id"
    t.index ["event_id"], name: "index_events_people_on_event_id"
    t.index ["person_id"], name: "index_events_people_on_person_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "title", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_meetings_on_team_id"
  end

  create_table "people", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.date "birthday"
    t.integer "gender", default: 2, null: false
    t.string "address", default: "", null: false
    t.string "celular_number", default: "", null: false
    t.string "cpf", default: ""
    t.string "full_name", null: false
    t.string "nickname", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "rg", default: ""
    t.string "type"
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "authorization_level", default: 0, null: false
    t.bigint "team_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_people_on_company_id"
    t.index ["cpf"], name: "index_people_on_cpf", unique: true, where: "(((cpf)::text <> ''::text) AND (cpf IS NOT NULL))"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true
    t.index ["rg"], name: "index_people_on_rg", unique: true, where: "(((rg)::text <> ''::text) AND (rg IS NOT NULL))"
    t.index ["team_id"], name: "index_people_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "axis_id", null: false
    t.string "link_teams", default: "", null: false
    t.string "link_miro", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["axis_id"], name: "index_teams_on_axis_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attendances", "meetings"
  add_foreign_key "attendances", "people"
  add_foreign_key "clusters", "people"
  add_foreign_key "meetings", "teams"
  add_foreign_key "people", "companies"
  add_foreign_key "people", "teams"
  add_foreign_key "teams", "axes"
end
