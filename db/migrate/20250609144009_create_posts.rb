class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :image_uid
      t.string :image_name
      t.integer :position

      t.timestamps
    end
  end
end
