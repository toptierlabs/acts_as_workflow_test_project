# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creates the node

User.create(
  role: 'admin',
  name: Faker::Name.name,
  age: Faker::Number.number(2)
)

seller = User.create(
  role: 'seller',
  name: Faker::Name.name,
  age: Faker::Number.number(2)
)

User.create(
  role: 'buyer',
  name: Faker::Name.name,
  age: Faker::Number.number(2)
)

User.create(
  role: 'buyer',
  name: Faker::Name.name,
  age: Faker::Number.number(2)
)

      # t.string :name
      # t.text :description
      # t.string :url
      # t.string :url_text
      # t.string :img_url
      # t.string :fail_text
      # t.string :more_info
      # t.string :more_info_text

nodes_info = [
  {name: '', description: '', url: '', url_text: '', more_info: '', more_info_text: ''},
  {name: 'I plan to pay with cash.', description: 'Click here to use our escrow service', url: '', url_text: '', more_info: '', more_info_text: ''},
  {name: 'Take a test drive', description: 'Click here when you are done with the test drive', url: '', url_text: '', more_info: '', more_info_text: ''},
  {name: 'Bank Account', description: 'Add your bank account', url: '', url_text: '', more_info: 'More info...', more_info_text:  "You'll need this to complete the sale"},
  {name: 'Add your legal name and address', description: "You'll be preparing your closing docs at no charge", url: '', url_text: '', more_info: '', more_info_text: ''},
  {name: 'Add the title and registration', description: 'Our pre-sale checklist will help you verify  your ownership docs are in order', url: '', url_text: '', more_info: '', more_info_text: ''},
  {name: 'Aprove test drive test', description: 'Click here to aprove the test drive test', url: '', url_text: '', more_info: '', more_info_text: ''},
  {name: '', description: '', url: '', url_text: '', more_info: '', more_info_text: ''},
  {name: '', description: '', url: '', url_text: '', more_info: '', more_info_text: ''}  
]

#Creates a listing
seller.listings.create

v = Workflow::Process.first.process_versions.create(
      version: '123'
    )

owners = %w(all buyer buyer seller seller seller admin seller all)
9.times do |i|
  node_info = nodes_info[i]
  node_info[:owner] = owners[i].to_sym
  v.process_graph_nodes.create(node_info)
end

Workflow::Process.first.process_versions.first.update_column(
  :process_graph_node_id,
  Workflow::ProcessGraphNode.find(1).id
)

n = Workflow::ProcessGraphNode.find 1
(2..6).each do |i|
  n.successor_nodes << Workflow::ProcessGraphNode.find(i)
end
n = Workflow::ProcessGraphNode.find 2
n.successor_nodes << Workflow::ProcessGraphNode.find(8)

n = Workflow::ProcessGraphNode.find 3
n.successor_nodes << Workflow::ProcessGraphNode.find(7)

n = Workflow::ProcessGraphNode.find 7
n.successor_nodes << Workflow::ProcessGraphNode.find(8)


(4..6).each do |i|
  n = Workflow::ProcessGraphNode.find(i)
  n.successor_nodes << Workflow::ProcessGraphNode.find(8)
  n.complete_globally = true
  n.save
end

n = Workflow::ProcessGraphNode.find 8
n.successor_nodes << Workflow::ProcessGraphNode.find(9)

# Validations

n = Workflow::ProcessGraphNode.find 7
n.when_complete_invalidate_nodes = [2].to_a
n.save

# Children completed
[7, 8, 9].each do |i|
  n = Workflow::ProcessGraphNode.find(i)
  n.process_graph_node_requisites.create(
    validator_type: :children_completed
  )
end

# Complete by buyer
[2, 3].each do |i|
  n = Workflow::ProcessGraphNode.find(i)
  n.process_graph_node_requisites.create(
    validator_type: :user,
    validator_content: :buyer
  )
end

# Complete by seller
[4, 5, 6, 8].each do |i|
  n = Workflow::ProcessGraphNode.find(i)
  n.process_graph_node_requisites.create(
    validator_type: :user,
    validator_content: :seller
  )
end

# Complete by admin
[7].each do |i|
  n = Workflow::ProcessGraphNode.find(i)
  n.process_graph_node_requisites.create(
    validator_type: :user,
    validator_content: :admin
  )
end

# Custom logic
[4, 5, 6].each do |i|
  n = Workflow::ProcessGraphNode.find(i)
  n.process_graph_node_requisites.create(
    validator_type: :custom_logic,
    validator_content: "condition_#{i-3}"
  )
end
