class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :name
      t.string :original_url
      t.string :slug

      t.timestamps
    end
    add_index :links, :slug, unique: true
  end
end
