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

ActiveRecord::Schema.define(version: 20141107121723) do

  create_table "answers", force: true do |t|
    t.string   "content"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "exam_categories", force: true do |t|
    t.string "name"
    t.string "permalink"
    t.text   "info"
  end

  create_table "exams", force: true do |t|
    t.string   "title"
    t.text     "description",          limit: 255
    t.integer  "user_id"
    t.float    "price"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "permalink"
    t.integer  "exam_category_id"
  end

  add_index "exams", ["exam_category_id"], name: "index_exams_on_exam_category_id"

  create_table "purchases", force: true do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.float    "performance"
  end

  add_index "purchases", ["exam_id"], name: "index_purchases_on_exam_id"
  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id"

  create_table "questions", force: true do |t|
    t.integer  "exam_id"
    t.text     "content"
    t.integer  "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "questions", ["exam_id"], name: "index_questions_on_exam_id"

  create_table "rankings", force: true do |t|
    t.integer "user_id"
    t.integer "exam_id"
    t.float   "performance"
  end

  add_index "rankings", ["exam_id"], name: "index_rankings_on_exam_id"
  add_index "rankings", ["user_id"], name: "index_rankings_on_user_id"

  create_table "ratings", force: true do |t|
    t.integer  "exam_id"
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["exam_id"], name: "index_ratings_on_exam_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "user_answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "purchase_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.string   "status"
    t.integer  "seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "answer"
  end

  add_index "user_answers", ["answer_id"], name: "index_user_answers_on_answer_id"
  add_index "user_answers", ["purchase_id"], name: "index_user_answers_on_purchase_id"
  add_index "user_answers", ["question_id"], name: "index_user_answers_on_question_id"
  add_index "user_answers", ["user_id"], name: "index_user_answers_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "name"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "bio"
    t.string   "permalink"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
