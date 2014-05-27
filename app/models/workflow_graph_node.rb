class WorkflowGraphNode < ActiveRecord::Base
  belongs_to :workflow_version
end
