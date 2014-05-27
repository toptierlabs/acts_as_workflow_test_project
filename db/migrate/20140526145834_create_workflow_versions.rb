class CreateWorkflowVersions < ActiveRecord::Migration
  def change
    create_table :workflow_versions do |t|
      t.string :version
      t.references :workflow_graph_node, index: true

      t.timestamps
    end
  end
end
