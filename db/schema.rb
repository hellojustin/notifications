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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130118034103) do

  create_table "commits", :force => true do |t|
    t.string   "branch"
    t.text     "comment"
    t.string   "committer"
    t.integer  "user_id"
    t.datetime "date"
    t.string   "repository"
    t.string   "revision"
    t.text     "diff"
  end

  add_index "commits", ["branch"], :name => "index_commits_on_branch"
  add_index "commits", ["comment"], :name => "index_commits_on_comment"
  add_index "commits", ["committer"], :name => "index_commits_on_committer"
  add_index "commits", ["date"], :name => "index_commits_on_date"
  add_index "commits", ["diff"], :name => "index_commits_on_diff"
  add_index "commits", ["repository"], :name => "index_commits_on_repository"
  add_index "commits", ["revision"], :name => "index_commits_on_revision"

  create_table "notification_rules", :force => true do |t|
    t.integer "user_id"
    t.string  "action"
    t.string  "repository_expr"
    t.string  "branch_expr"
    t.string  "committer_expr"
    t.string  "comment_expr"
  end

  add_index "notification_rules", ["action"], :name => "index_notification_rules_on_action"
  add_index "notification_rules", ["user_id"], :name => "index_notification_rules_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer "user_id"
    t.integer "commit_id"
  end

  add_index "notifications", ["commit_id"], :name => "index_notifications_on_commit_id"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
