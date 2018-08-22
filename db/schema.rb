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

ActiveRecord::Schema.define(version: 20180816171038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action",         limit: 255
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seen",                       default: false
  end

  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "alltags", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answer_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: :cascade do |t|
    t.text     "body"
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "accepted"
    t.text     "body_plain"
    t.boolean  "send_mail",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_agent",  limit: 255
    t.string   "user_ip",     limit: 255
    t.string   "referrer",    limit: 255
    t.integer  "vote_count",              default: 0
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",   limit: 255
    t.string   "slug",        limit: 255
    t.string   "image",       limit: 255
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry",         limit: 255
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree

  create_table "direct_messages", force: :cascade do |t|
    t.string   "created_by", limit: 255
    t.string   "title",      limit: 255
    t.string   "body",       limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favourites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree

  create_table "page_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon",        limit: 255
  end

  create_table "page_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "address"
    t.string   "zip_code",          limit: 255
    t.string   "phone",             limit: 255
    t.integer  "privacy_id"
    t.string   "website",           limit: 255
    t.text     "long_description"
    t.text     "short_description"
    t.string   "cover_picture",     limit: 255
    t.string   "logo",              limit: 255
    t.integer  "user_id"
    t.integer  "page_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "privacies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_progresses", force: :cascade do |t|
    t.boolean  "written_bio",       default: false
    t.boolean  "updated_question",  default: false
    t.boolean  "asked_question",    default: false
    t.boolean  "followed_someone",  default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "answered_question", default: false
    t.boolean  "voted_for_content", default: false
  end

  create_table "question_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.integer  "views",                         default: 0
    t.integer  "answers_count",                 default: 0
    t.string   "permalink",         limit: 255
    t.integer  "answer_id"
    t.boolean  "send_mail",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",              limit: 255
    t.integer  "category_id"
    t.string   "ancestry",          limit: 255
    t.integer  "comments_count",                default: 0
    t.integer  "favourites_count",              default: 0
    t.string   "picture",           limit: 255
    t.integer  "page_id"
    t.string   "questionable_type", limit: 255
    t.integer  "vote_count",                    default: 0
  end

  add_index "questions", ["ancestry"], name: "index_questions_on_ancestry", using: :btree
  add_index "questions", ["slug"], name: "index_questions_on_slug", unique: true, using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "reputation_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "context",    limit: 255
    t.integer  "points",                 default: 0
    t.integer  "reputation",             default: 0
    t.integer  "vote_id",                default: 0
    t.integer  "answer_id",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reputation_histories", ["user_id", "context"], name: "index_reputation_histories_on_user_id_and_context", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",              limit: 255
    t.integer "taggings_count",                default: 0
    t.string  "image",             limit: 255
    t.text    "description"
    t.string  "banner",            limit: 255
    t.integer "category_id"
    t.integer "count_users",                   default: 0
    t.text    "short_description"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   limit: 255, default: "",      null: false
    t.string   "encrypted_password",      limit: 255, default: "",      null: false
    t.string   "reset_password_token",    limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      limit: 255
    t.string   "last_sign_in_ip",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                limit: 255
    t.string   "avatar",                  limit: 255
    t.integer  "views",                               default: 0
    t.datetime "last_requested_at"
    t.string   "avatar_file_name",        limit: 255
    t.string   "avatar_content_type",     limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin"
    t.integer  "reputation"
    t.string   "slug",                    limit: 255
    t.datetime "banned_at"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "gender",                  limit: 255
    t.text     "bio"
    t.string   "occupation",              limit: 255
    t.string   "title",                   limit: 255
    t.string   "intrest",                 limit: 255
    t.boolean  "moderator",                           default: false
    t.boolean  "only_follower_feed",                  default: false
    t.string   "provider",                limit: 255, default: "email"
    t.string   "uid",                     limit: 255
    t.integer  "category_id"
    t.string   "city",                    limit: 255
    t.string   "country",                 limit: 255
    t.string   "twitter_url",             limit: 255
    t.string   "facebook_url",            limit: 255
    t.string   "personal_website",        limit: 255
    t.string   "cover_photo",             limit: 255
    t.string   "location",                limit: 255
    t.integer  "progress",                            default: 0
    t.integer  "count_tags",                          default: 0
    t.boolean  "allow_password_change",               default: false
    t.json     "tokens"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.string   "login_token"
    t.datetime "login_token_valid_until"
    t.string   "access_token"
    t.datetime "access_token_expired_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
