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

ActiveRecord::Schema.define(version: 20140530181141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: true do |t|
    t.integer  "user_id"
    t.boolean  "condition_1"
    t.boolean  "condition_2"
    t.boolean  "condition_3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "role"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workflow_process_graph_edges", force: true do |t|
    t.integer  "process_graph_node_id"
    t.integer  "end_node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_process_graph_edges", ["end_node_id"], name: "index_workflow_process_graph_edges_on_end_node_id", using: :btree
  add_index "workflow_process_graph_edges", ["process_graph_node_id"], name: "index_workflow_process_graph_edges_on_process_graph_node_id", using: :btree

  create_table "workflow_process_graph_node_requisites", force: true do |t|
    t.integer  "process_graph_node_id"
    t.integer  "validator_type"
    t.text     "validator_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_process_graph_node_requisites", ["process_graph_node_id"], name: "process_graph_node_on_process_graph_node_requisites_index", using: :btree

  create_table "workflow_process_graph_nodes", force: true do |t|
    t.integer  "process_version_id"
    t.integer  "priority"
    t.string   "owner"
    t.boolean  "complete_globally"
    t.string   "when_complete_invalidate_nodes"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "url_text"
    t.string   "img_url"
    t.string   "fail_text"
    t.string   "more_info"
    t.string   "more_info_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_process_graph_nodes", ["process_version_id"], name: "index_workflow_process_graph_nodes_on_process_version_id", using: :btree

  create_table "workflow_process_instance_edges", force: true do |t|
    t.integer  "process_instance_node_id"
    t.integer  "end_instance_node_id"
    t.integer  "process_graph_edge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_process_instance_edges", ["end_instance_node_id"], name: "index_workflow_process_instance_edges_on_end_instance_node_id", using: :btree
  add_index "workflow_process_instance_edges", ["process_graph_edge_id"], name: "index_workflow_process_instance_edges_on_process_graph_edge_id", using: :btree

  create_table "workflow_process_instance_nodes", force: true do |t|
    t.integer  "process_instance_id"
    t.integer  "process_graph_node_id"
    t.datetime "completed_at"
    t.datetime "canceled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_process_instance_nodes", ["process_graph_node_id"], name: "index_workflow_process_instance_nodes_on_process_graph_node_id", using: :btree
  add_index "workflow_process_instance_nodes", ["process_instance_id"], name: "index_workflow_process_instance_nodes_on_process_instance_id", using: :btree

  create_table "workflow_process_instances", force: true do |t|
    t.integer  "process_version_id"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.integer  "user_id"
    t.integer  "dummy_instance_node_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_process_instances", ["dummy_instance_node_id"], name: "index_workflow_process_instances_on_dummy_instance_node_id", using: :btree
  add_index "workflow_process_instances", ["entity_id", "entity_type"], name: "index_workflow_process_instances_on_entity_id_and_entity_type", using: :btree
  add_index "workflow_process_instances", ["process_version_id"], name: "index_workflow_process_instances_on_process_version_id", using: :btree
  add_index "workflow_process_instances", ["user_id"], name: "index_workflow_process_instances_on_user_id", using: :btree

  create_table "workflow_process_versions", force: true do |t|
    t.string   "version"
    t.integer  "process_graph_node_id"
    t.integer  "process_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workflow_process_versions", ["process_graph_node_id"], name: "index_workflow_process_versions_on_process_graph_node_id", using: :btree
  add_index "workflow_process_versions", ["process_id"], name: "index_workflow_process_versions_on_process_id", using: :btree

  create_table "workflow_processes", force: true do |t|
    t.string   "name"
    t.string   "entity_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
