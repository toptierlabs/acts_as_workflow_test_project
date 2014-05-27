class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :name
      t.string :entity_class

      t.timestamps
    end
  end
end
