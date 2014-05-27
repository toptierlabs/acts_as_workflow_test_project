class WorkflowGraphEdge < ActiveRecord::Base
  belongs_to :workflow_graph_node
  belongs_to :end_node
end
