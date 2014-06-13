# This migration comes from workflow (originally 20140527225246)
class CreateWorkflowProcessVersions < ActiveRecord::Migration
  def change
    create_table :workflow_process_versions do |t|
      t.string :version
      t.references :process_graph_node, index: true
      t.references :process, index: true

      t.timestamps
    end
  end
end
