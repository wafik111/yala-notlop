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

ActiveRecord::Schema.define(version: 2019_02_24_205607) do

  create_table "friendship_notifications", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.string "friendable_type"
    t.integer "friendable_id"
    t.integer "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "blocker_id"
    t.integer "status"
    t.index ["friendable_id", "friend_id"], name: "index_friendships_on_friendable_id_and_friend_id", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "invited_members", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_invited_members_on_order_id"
    t.index ["user_id"], name: "index_invited_members_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "order_informations", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.string "item_name"
    t.float "item_price"
    t.integer "amount"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_informations_on_order_id"
    t.index ["user_id"], name: "index_order_informations_on_user_id"
  end

  create_table "order_notifications", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.integer "status"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_notifications_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "ends_at"
    t.string "resturant"
    t.string "menu_file_name"
    t.string "menu_content_type"
    t.integer "menu_file_size"
    t.datetime "menu_updated_at"
    t.integer "meal"
    t.integer "status"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'attachment' for column 'avatar'

end
