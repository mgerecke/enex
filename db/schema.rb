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

ActiveRecord::Schema.define(:version => 20140729193809) do

# Could not dump table "City_Locations" because of following StandardError
#   Unknown type '' for column 'geoname_id'

# Could not dump table "city_blocks" because of following StandardError
#   Unknown type '' for column 'network_start_ip'

# Could not dump table "city_locations_de" because of following StandardError
#   Unknown type '' for column 'geoname_id'

  create_table "experts", :force => true do |t|
    t.string   "firmenname"
    t.string   "anrede"
    t.string   "titel"
    t.string   "vorname"
    t.string   "name"
    t.string   "strasse"
    t.string   "hausnr"
    t.string   "plz_7"
    t.string   "plz"
    t.string   "ort"
    t.string   "vorwahl"
    t.string   "telefon"
    t.string   "email",                                     :null => false
    t.string   "website"
    t.string   "ausbildung"
    t.boolean  "bafa",                   :default => false, :null => false
    t.boolean  "kfw_bauen_und_sanieren", :default => false, :null => false
    t.boolean  "energ_fachplanung",      :default => false, :null => false
    t.boolean  "baubegleitung",          :default => false, :null => false
    t.boolean  "kfw_denkmal",            :default => false, :null => false
    t.string   "created_by"
    t.string   "update_by"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "experts", ["email"], :name => "index_experts_on_email", :unique => true
  add_index "experts", ["plz_7"], :name => "index_experts_on_plz_7"

  create_table "experts2", :force => true do |t|
    t.string   "firma",      :limit => 50
    t.string   "plz",        :limit => 5
    t.string   "ort",        :limit => 50
    t.string   "objekt_art", :limit => 5
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.text     "email"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
