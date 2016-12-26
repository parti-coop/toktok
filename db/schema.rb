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

ActiveRecord::Schema.define(version: 20161226141831) do

  create_table "assigned_committees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC" do |t|
    t.integer  "committee_id", null: false
    t.integer  "project_id",   null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["committee_id", "project_id"], name: "index_assigned_committees_on_committee_id_and_project_id", unique: true, using: :btree
    t.index ["committee_id"], name: "index_assigned_committees_on_committee_id", using: :btree
    t.index ["project_id"], name: "index_assigned_committees_on_project_id", using: :btree
  end

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string   "source"
    t.string   "name"
    t.string   "source_type"
    t.string   "attachable_type"
    t.integer  "attachable_id",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.text     "body",             limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "likes_count",                    default: 0
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "committees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "congressmen", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string   "name"
    t.string   "description"
    t.string   "party"
    t.integer  "committee_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "image"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "email"
    t.string   "homepage_url"
    t.index ["committee_id"], name: "index_congressmen_on_committee_id", using: :btree
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.integer  "user_id"
    t.string   "likable_type"
    t.integer  "likable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "mainslides", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "order",                     null: false
    t.string   "image",                     null: false
    t.text     "url",         limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "description", limit: 65535
  end

  create_table "matches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.integer  "project_id",                     null: false
    t.integer  "congressman_id",                 null: false
    t.string   "status"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "matching_comment", limit: 65535
    t.index ["congressman_id"], name: "index_matches_on_congressman_id", using: :btree
    t.index ["project_id", "congressman_id"], name: "index_matches_on_project_id_and_congressman_id", unique: true, using: :btree
    t.index ["project_id"], name: "index_matches_on_project_id", using: :btree
  end

  create_table "mentions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC" do |t|
    t.integer  "congressman_id", null: false
    t.integer  "comment_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["comment_id"], name: "index_mentions_on_comment_id", using: :btree
    t.index ["congressman_id", "comment_id"], name: "index_mentions_on_congressman_id_and_comment_id", unique: true, using: :btree
    t.index ["congressman_id"], name: "index_mentions_on_congressman_id", using: :btree
  end

  create_table "participations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC" do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_participations_on_project_id", using: :btree
    t.index ["user_id", "project_id"], name: "index_participations_on_user_id_and_project_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_participations_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string   "title"
    t.text     "body",                      limit: 16777215
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "participations_count",                       default: 0
    t.integer  "participations_goal_count",                  default: 1000
    t.string   "image"
    t.text     "summary",                   limit: 16777215
    t.text     "proposer_description",      limit: 16777215
    t.datetime "deleted_at"
    t.text     "matching_staff_message",    limit: 65535
    t.string   "proposer"
    t.string   "running_platform_url"
    t.string   "proposer_email"
    t.string   "proposer_phone"
    t.text     "running_staff_message",     limit: 65535
    t.integer  "primary_committee_id"
    t.string   "status",                                     default: ""
    t.text     "fail_staff_message",        limit: 65535
    t.index ["deleted_at"], name: "index_projects_on_deleted_at", using: :btree
    t.index ["proposal_id"], name: "index_projects_on_proposal_id", using: :btree
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "proposals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body",           limit: 16777215
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "proposer_name"
    t.string   "proposer_email"
    t.string   "proposer_phone"
    t.string   "image"
    t.index ["user_id"], name: "index_proposals_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.integer  "user_id",    null: false
    t.string   "title"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "redactor2_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["assetable_type", "assetable_id"], name: "idx_redactor2_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_redactor2_assetable_type", using: :btree
  end

  create_table "timelines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "actor"
    t.string   "image"
    t.text     "body",           limit: 65535, null: false
    t.integer  "project_id",                   null: false
    t.integer  "congressman_id"
    t.datetime "timeline_date",                null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["congressman_id"], name: "index_timelines_on_congressman_id", using: :btree
    t.index ["project_id"], name: "index_timelines_on_project_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC" do |t|
    t.string   "email"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "image"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "role"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
    t.index ["role"], name: "index_users_on_role", using: :btree
  end

  add_foreign_key "comments", "users"
  add_foreign_key "congressmen", "committees"
  add_foreign_key "likes", "users"
end
