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

ActiveRecord::Schema[7.1].define(version: 2024_08_14_194156) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "education_levels", ["TVET", "Secondary School", "Certificate", "Diploma", "Bachelors Degree", "Masters Degree", "PHD. Doctoral Degree", "Not Required"]
  create_enum "employment_types", ["Full-Time", "Part-Time", "Freelance", "Contract", "Volunteership", "Internship", "Unpaid Internship"]
  create_enum "experience_levels", ["Junior Level", "Mid-Level", "Senior Level"]
  create_enum "job_site_types", ["On-Site", "Remote"]
  create_enum "status_types", ["in-review", "approved", "declined"]
  create_enum "user_roles", ["job_seeker", "private_client", "company"]

  create_table "companies", primary_key: "company_id", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name", null: false
    t.string "city", null: false
    t.text "logo_img_url"
    t.text "description"
    t.string "industry"
    t.string "website"
    t.string "tin_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id", unique: true
  end

  create_table "feedbacks", primary_key: "feedback_id", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "feedback_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "job_applications", primary_key: "job_application_id", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.text "contact"
    t.text "cv_document_url", null: false
    t.text "cover_letter", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id", "user_id"], name: "index_job_applications_on_job_id_and_user_id"
    t.index ["job_id"], name: "index_job_applications_on_job_id"
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "jobs", primary_key: "job_id", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.enum "job_site", default: "Remote", enum_type: "job_site_types"
    t.string "city"
    t.text "description"
    t.enum "experience_required", enum_type: "experience_levels"
    t.enum "education_level", default: "Not Required", enum_type: "education_levels"
    t.enum "employment_type", enum_type: "employment_types"
    t.integer "salary"
    t.integer "vacancies"
    t.enum "status", default: "in-review", enum_type: "status_types"
    t.datetime "deadline", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_jobs_on_title"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "private_clients", primary_key: "private_client_id", force: :cascade do |t|
    t.string "location"
    t.string "verification_type"
    t.text "verification_document_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_private_clients_on_user_id", unique: true
  end

  create_table "saved_jobs", primary_key: "saved_job_id", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_saved_jobs_on_job_id"
    t.index ["user_id", "job_id"], name: "index_saved_jobs_on_user_id_and_job_id"
    t.index ["user_id"], name: "index_saved_jobs_on_user_id"
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.string "telegram_user_id", null: false
    t.enum "role", null: false, enum_type: "user_roles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["telegram_user_id"], name: "index_users_on_telegram_user_id"
  end

  add_foreign_key "companies", "users", primary_key: "user_id"
  add_foreign_key "feedbacks", "users", primary_key: "user_id"
  add_foreign_key "job_applications", "jobs", primary_key: "job_id"
  add_foreign_key "job_applications", "users", primary_key: "user_id"
  add_foreign_key "jobs", "users", primary_key: "user_id"
  add_foreign_key "private_clients", "users", primary_key: "user_id"
  add_foreign_key "saved_jobs", "jobs", primary_key: "job_id"
  add_foreign_key "saved_jobs", "users", primary_key: "user_id"
end
