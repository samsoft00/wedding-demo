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

ActiveRecord::Schema.define(version: 20160602190344) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "slug",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "type_id",     limit: 4
  end

  create_table "categories_listings", id: false, force: :cascade do |t|
    t.integer "listing_id",  limit: 4, null: false
    t.integer "category_id", limit: 4, null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.integer  "listing_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "gallaries", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "site_id",    limit: 4
  end

  add_index "gallaries", ["site_id"], name: "index_gallaries_on_site_id", using: :btree

  create_table "listing_images", force: :cascade do |t|
    t.integer  "listing_id",         limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "listing_images", ["listing_id"], name: "index_listing_images_on_Listing_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "details",           limit: 65535
    t.string   "slug",              limit: 255
    t.string   "pricing_and_faq",   limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "profile_id",        limit: 4
    t.integer  "user_id",           limit: 4
    t.text     "short_description", limit: 65535
    t.string   "status",            limit: 255
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id",   limit: 4
    t.string  "unsubscriber_type", limit: 255
    t.integer "conversation_id",   limit: 4
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type",                 limit: 255
    t.text     "body",                 limit: 65535
    t.string   "subject",              limit: 255,   default: ""
    t.integer  "sender_id",            limit: 4
    t.string   "sender_type",          limit: 255
    t.integer  "conversation_id",      limit: 4
    t.boolean  "draft",                              default: false
    t.string   "notification_code",    limit: 255
    t.integer  "notified_object_id",   limit: 4
    t.string   "notified_object_type", limit: 255
    t.string   "attachment",           limit: 255
    t.datetime "updated_at",                                         null: false
    t.datetime "created_at",                                         null: false
    t.boolean  "global",                             default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id",     limit: 4
    t.string   "receiver_type",   limit: 255
    t.integer  "notification_id", limit: 4,                   null: false
    t.boolean  "is_read",                     default: false
    t.boolean  "trashed",                     default: false
    t.boolean  "deleted",                     default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "our_stories", force: :cascade do |t|
    t.integer  "site_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "how_we_meet", limit: 65535
    t.text     "first_date",  limit: 65535
    t.text     "proposal",    limit: 65535
  end

  add_index "our_stories", ["site_id"], name: "index_our_stories_on_site_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "imageable_type", limit: 255
    t.integer  "imageable_id",   limit: 4
    t.string   "description",    limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "image_id",       limit: 255
  end

  add_index "pictures", ["imageable_id"], name: "index_pictures_on_imageable_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "business_name",    limit: 255
    t.string   "phone",            limit: 255
    t.string   "website",          limit: 255
    t.string   "facebook",         limit: 255
    t.string   "twitter",          limit: 255
    t.string   "instagram",        limit: 255
    t.string   "address",          limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id",          limit: 4
    t.integer  "category_id",      limit: 4
    t.string   "about",            limit: 255
    t.string   "city",             limit: 255
    t.string   "state",            limit: 255
    t.string   "country",          limit: 255
    t.string   "profile_image_id", limit: 255
    t.string   "services",         limit: 255
    t.string   "status",           limit: 255
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating",     limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
    t.integer  "listing_id", limit: 4
  end

  create_table "rsvps", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "phone",                  limit: 255
    t.integer  "attending",              limit: 4
    t.integer  "how_many_are_you_bring", limit: 4
    t.integer  "site_id",                limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "rsvps", ["site_id"], name: "index_rsvps_on_site_id", using: :btree

  create_table "site_layouts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.string   "color",      limit: 255
    t.integer  "site_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "site_layouts", ["site_id"], name: "index_site_layouts_on_site_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "groom_name",     limit: 255
    t.string   "bride_name",     limit: 255
    t.text     "about_groom",    limit: 65535
    t.text     "about_bride",    limit: 65535
    t.date     "wedding_date"
    t.string   "photographer",   limit: 255
    t.string   "event_planner",  limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "groom_image_id", limit: 255
    t.string   "bride_image_id", limit: 255
    t.string   "status",         limit: 255
  end

  add_index "sites", ["user_id"], name: "index_sites_on_user_id", using: :btree

  create_table "sliders", force: :cascade do |t|
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "site_id",     limit: 4
  end

  add_index "sliders", ["site_id"], name: "index_sliders_on_site_id", using: :btree

  create_table "templates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "color",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "username",               limit: 255
    t.string   "site_status",            limit: 255
    t.boolean  "is_vendor"
    t.boolean  "is_couple"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "wedding_features", force: :cascade do |t|
    t.string  "features",           limit: 255
    t.integer "wedding_package_id", limit: 4
  end

  add_index "wedding_features", ["wedding_package_id"], name: "index_wedding_features_on_wedding_package_id", using: :btree

  create_table "wedding_locations", force: :cascade do |t|
    t.text     "venue",      limit: 65535
    t.integer  "site_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "event_type", limit: 255
    t.string   "date",       limit: 255
    t.string   "from",       limit: 255
    t.string   "to",         limit: 255
  end

  add_index "wedding_locations", ["site_id"], name: "index_wedding_locations_on_site_id", using: :btree

  create_table "wedding_packages", force: :cascade do |t|
    t.string  "package",     limit: 255
    t.decimal "amount",                  precision: 10
    t.string  "description", limit: 255
  end

  add_foreign_key "gallaries", "sites"
  add_foreign_key "listing_images", "listings", column: "Listing_id"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "our_stories", "sites"
  add_foreign_key "rsvps", "sites"
  add_foreign_key "site_layouts", "sites"
  add_foreign_key "sites", "users"
  add_foreign_key "sliders", "sites"
  add_foreign_key "wedding_features", "wedding_packages"
  add_foreign_key "wedding_locations", "sites"
end
