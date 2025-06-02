class CreateBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :blocks do |t|
      t.string :type
      t.text :data
      t.integer :parent_id, default: 0, null: false
      t.integer :position, default: 0, null: false
      t.integer :children_count, default: 0, null: false
      t.references :block_area

      t.timestamps

      t.index [:parent_id, :position]
    end
  end
end
