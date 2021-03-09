class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :slug

      t.timestamps
    end
    add_index :links, :slug, unique: true
  end
end
