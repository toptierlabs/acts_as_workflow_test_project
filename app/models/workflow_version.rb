class WorkflowVersion < ActiveRecord::Base
  belongs_to :workflow_graph_node
end
