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

ActiveRecord::Schema.define(version: 20150819214350) do

  create_table 'group_permissions', force: true do |t|
    t.integer 'group_id'
    t.string 'node'
    t.boolean 'negative'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'group_permissions', ['group_id'], name: 'index_group_permissions_on_group_id'

  create_table 'groups', force: true do |t|
    t.string 'name'
    t.integer 'priority'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'user_groups', force: true do |t|
    t.integer 'user_id'
    t.integer 'group_id'
    t.boolean 'active'
    t.datetime 'expires_at'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'user_groups', ['group_id'], name: 'index_user_groups_on_group_id'
  add_index 'user_groups', ['user_id'], name: 'index_user_groups_on_user_id'

  create_table 'users', force: true do |t|
    t.string 'display_name'
    t.string 'uuid'
    t.string 'locale'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

end
