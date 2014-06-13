# This migration comes from workflow (originally 20140527225800)
class CreateWorkflowProcessGraphEdges < ActiveRecord::Migration
  def change
    create_table :workflow_process_graph_edges do |t|
      t.references :process_graph_node, index: true
      t.references :end_node, index: true

      t.timestamps
    end
  end
end
