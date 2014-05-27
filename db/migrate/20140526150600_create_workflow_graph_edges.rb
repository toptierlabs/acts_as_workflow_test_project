class CreateWorkflowGraphEdges < ActiveRecord::Migration
  def change
    create_table :workflow_graph_edges do |t|
      t.references :workflow_graph_node, index: true
      t.references :end_node, index: true

      t.timestamps
    end
  end
end
