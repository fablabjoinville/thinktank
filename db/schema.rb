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

ActiveRecord::Schema[7.0].define(version: 2023_05_21_184106) do
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

  create_table "attendances", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "event_id", null: false
    t.integer "status", default: 0, null: false
    t.text "reason", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_attendances_on_event_id"
    t.index ["member_id", "event_id"], name: "index_attendances_on_member_id_and_event_id", unique: true
    t.index ["member_id"], name: "index_attendances_on_member_id"
  end

  create_table "axes", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clusters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.integer "week_day", null: false
    t.string "address"
    t.integer "modality", null: false
    t.text "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clusters_on_user_id"
  end

  create_table "clusters_teams", id: false, force: :cascade do |t|
    t.bigint "cluster_id", null: false
    t.bigint "team_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "title", null: false
    t.date "date", null: false
    t.integer "ref", null: false
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
    t.index ["team_id"], name: "index_events_on_team_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", default: "", null: false
    t.date "birthday"
    t.string "nickname", default: "", null: false
    t.string "cpf"
    t.string "rg"
    t.string "phone_number", default: "", null: false
    t.string "celular_number", default: "", null: false
    t.string "address", default: "", null: false
    t.integer "gender", default: 2, null: false
    t.boolean "active", default: true, null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.index ["cpf"], name: "index_members_on_cpf", unique: true
    t.index ["rg"], name: "index_members_on_rg", unique: true
    t.index ["team_id"], name: "index_members_on_team_id"
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

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.date "birthday"
    t.string "nickname", default: "", null: false
    t.string "cpf"
    t.string "rg"
    t.string "phone_number", default: "", null: false
    t.string "celular_number", default: "", null: false
    t.string "address", default: "", null: false
    t.integer "gender", default: 2, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "authorization_level", default: 0, null: false
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rg"], name: "index_users_on_rg", unique: true
  end

  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "members"
  add_foreign_key "clusters", "users"
  add_foreign_key "events", "teams"
  add_foreign_key "members", "teams"
  add_foreign_key "teams", "axes"
end
