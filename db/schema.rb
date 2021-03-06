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

ActiveRecord::Schema.define(:version => 20120820135319) do

  create_table "boards", :force => true do |t|
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "card_archetypes", :force => true do |t|
    t.string   "name"
    t.integer  "colorlessCost", :default => 0
    t.integer  "greenCost",     :default => 0
    t.integer  "redCost",       :default => 0
    t.integer  "whiteCost",     :default => 0
    t.integer  "blueCost",      :default => 0
    t.integer  "blackCost",     :default => 0
    t.integer  "power",         :default => 0
    t.integer  "toughness",     :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "card_archetypes_rules", :force => true do |t|
    t.integer "card_archetype_id"
    t.integer "rule_id"
  end

  create_table "cards", :force => true do |t|
    t.integer  "card_holder_id"
    t.string   "card_holder_type"
    t.integer  "card_archetype_id"
    t.integer  "position"
    t.boolean  "tapped"
    t.boolean  "summoning_sick"
    t.boolean  "attacking"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "games", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "graveyards", :force => true do |t|
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hands", :force => true do |t|
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "libraries", :force => true do |t|
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mana_pools", :force => true do |t|
    t.integer  "green",      :default => 0
    t.integer  "white",      :default => 0
    t.integer  "red",        :default => 0
    t.integer  "blue",       :default => 0
    t.integer  "black",      :default => 0
    t.integer  "colorless",  :default => 0
    t.integer  "player_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "players", :force => true do |t|
    t.integer  "game_id"
    t.integer  "turn_id"
    t.integer  "life_total"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "results", :force => true do |t|
    t.string   "winner"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rules", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stack_frames", :force => true do |t|
    t.integer  "stack_id"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stacks", :force => true do |t|
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "turn_actions", :force => true do |t|
    t.string   "name"
    t.integer  "player_id"
    t.integer  "card_id"
    t.integer  "turn_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "turns", :force => true do |t|
    t.string   "phase"
    t.integer  "count"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
