class CreateWorkflowGraphNodes < ActiveRecord::Migration
  def change
    create_table :workflow_graph_nodes do |t|
      t.references :workflow_version, index: true
      t.integer :priority
      t.integer :owner
      t.string :when_complete_invalidate_nodes

      t.timestamps
    end
  end
end
