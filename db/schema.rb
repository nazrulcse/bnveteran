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

ActiveRecord::Schema.define(version: 20180608101848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "admin_messages", force: :cascade do |t|
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.integer  "user_id"
    t.boolean  "is_read",    default: false
    t.index ["slug"], name: "index_admin_messages_on_slug", unique: true, using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.string   "photo"
    t.string   "name"
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_albums_on_slug", unique: true, using: :btree
  end

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
    t.index ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
    t.index ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
    t.index ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment_html"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
    t.index ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "event_datetime"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_up", default: 0
    t.integer  "comments_count",  default: 0
    t.string   "photo"
    t.text     "description"
    t.index ["cached_votes_up"], name: "index_events_on_cached_votes_up", using: :btree
    t.index ["comments_count"], name: "index_events_on_comments_count", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "facilities", force: :cascade do |t|
    t.string   "organization_name"
    t.text     "description"
    t.string   "form_title"
    t.string   "upload_facility_form"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "organization_logo"
    t.string   "slug"
    t.index ["slug"], name: "index_facilities_on_slug", unique: true, using: :btree
  end

  create_table "facility_forms", force: :cascade do |t|
    t.integer  "facility_id"
    t.string   "title"
    t.text     "form"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.index ["facility_id"], name: "index_facility_forms_on_facility_id", using: :btree
    t.index ["slug"], name: "index_facility_forms_on_slug", unique: true, using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type",                 null: false
    t.integer  "followable_id",                   null: false
    t.string   "follower_type",                   null: false
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "gallery_photos", force: :cascade do |t|
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "image"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "likable_id"
    t.string   "likable_type"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "current_user_id"
  end

  create_table "menu_bar_items", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.text     "content"
    t.boolean  "is_read"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "recipient_id"
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "photo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.index ["slug"], name: "index_news_on_slug", unique: true, using: :btree
  end

  create_table "notification_images", force: :cascade do |t|
    t.integer  "facility_id"
    t.string   "title"
    t.text     "photo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["facility_id"], name: "index_notification_images_on_facility_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.boolean  "checked"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "notification_type"
    t.integer  "notification_id"
    t.string   "topic_creator_name"
    t.integer  "topic_creator_id"
    t.boolean  "from_admin",         default: false
    t.index ["notification_type", "notification_id"], name: "index_notifications_on_notification_type_and_notification_id", using: :btree
  end

  create_table "page_banners", force: :cascade do |t|
    t.string   "banner_photo"
    t.integer  "menu_bar_item_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "post_images", force: :cascade do |t|
    t.integer  "post_id"
    t.text     "image"
    t.string   "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_images_on_post_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content",                         null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_up", default: 0
    t.integer  "comments_count",  default: 0
    t.text     "content_html"
    t.text     "attachments"
    t.boolean  "is_share",        default: false
    t.integer  "shared_id"
    t.integer  "share_count",     default: 0
    t.string   "slug"
    t.index ["cached_votes_up"], name: "index_posts_on_cached_votes_up", using: :btree
    t.index ["comments_count"], name: "index_posts_on_comments_count", using: :btree
    t.index ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_hashtag_hashtaggings", force: :cascade do |t|
    t.integer "hashtag_id"
    t.string  "hashtaggable_type"
    t.integer "hashtaggable_id"
    t.index ["hashtag_id"], name: "index_simple_hashtag_hashtaggings_on_hashtag_id", using: :btree
    t.index ["hashtaggable_id", "hashtaggable_type"], name: "index_hashtaggings_hashtaggable_id_hashtaggable_type", using: :btree
  end

  create_table "simple_hashtag_hashtags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.index ["name"], name: "index_simple_hashtag_hashtags_on_name", using: :btree
    t.index ["slug"], name: "index_simple_hashtag_hashtags_on_slug", unique: true, using: :btree
  end

  create_table "user_rooms", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "",     null: false
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "about"
    t.string   "avatar"
    t.string   "cover"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "sex",                    default: "male", null: false
    t.string   "location"
    t.date     "dob"
    t.string   "phone_number"
    t.integer  "posts_count",            default: 0,      null: false
    t.string   "slug"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.integer  "designation_type"
    t.integer  "rank"
    t.string   "officer_no"
    t.date     "date_joining"
    t.date     "date_retirement"
    t.string   "batch"
    t.string   "address"
    t.string   "state"
    t.string   "city"
    t.string   "country"
    t.string   "permanent_address"
    t.string   "present_address"
    t.string   "avatar_pdf"
    t.string   "present_state"
    t.string   "present_city"
    t.string   "present_country"
    t.boolean  "status",                 default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "facility_forms", "facilities"
  add_foreign_key "notification_images", "facilities"
  add_foreign_key "post_images", "posts"
end
