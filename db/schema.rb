# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100208093350) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.text     "answer"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  create_table "questions", :force => true do |t|
    t.integer  "test_id"
    t.text     "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  create_table "subjects", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_results", :force => true do |t|
    t.integer  "test_id"
    t.integer  "user_id"
    t.integer  "correct_count"
    t.integer  "incorrect_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "student_class"
  end

  add_index "test_results", ["user_id", "test_id"], :name => "index_test_results_on_user_id_and_test_id", :unique => true

  create_table "tests", :force => true do |t|
    t.integer  "subject_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password", :limit => 40
    t.string   "salt",             :limit => 40
  end

  create_table "user_answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_answers", ["user_id", "test_id", "question_id"], :name => "index_user_answers_on_user_id_and_test_id_and_question_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "role",                                     :default => 0
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
