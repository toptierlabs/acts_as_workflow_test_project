class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :user, index: true
      t.boolean :condition_1
      t.boolean :condition_2
      t.boolean :condition_3

      t.timestamps
    end
  end
end
