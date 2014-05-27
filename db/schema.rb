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

ActiveRecord::Schema.define(version: 20140526150600) do

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workflow_graph_edges", force: true do |t|
    t.integer  "workflow_graph_node_id"
    t.integer  "end_node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_graph_edges", ["end_node_id"], name: "index_workflow_graph_edges_on_end_node_id"
  add_index "workflow_graph_edges", ["workflow_graph_node_id"], name: "index_workflow_graph_edges_on_workflow_graph_node_id"

  create_table "workflow_graph_nodes", force: true do |t|
    t.integer  "workflow_version_id"
    t.integer  "priority"
    t.integer  "owner"
    t.string   "when_complete_invalidate_nodes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_graph_nodes", ["workflow_version_id"], name: "index_workflow_graph_nodes_on_workflow_version_id"

  create_table "workflow_versions", force: true do |t|
    t.string   "version"
    t.integer  "workflow_graph_node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_versions", ["workflow_graph_node_id"], name: "index_workflow_versions_on_workflow_graph_node_id"

  create_table "workflows", force: true do |t|
    t.string   "name"
    t.string   "entity_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
