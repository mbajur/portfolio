class CreateBlockAreas < ActiveRecord::Migration[5.2]

  def change
    create_table :block_areas do |t|
      t.string :label
      t.references :site
      t.string :identifier
      t.timestamps
    end
  end
end
