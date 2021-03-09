class CreateImpressions < ActiveRecord::Migration[6.1]
  def change
    create_table :impressions do |t|
      t.references :link, null: false, foreign_key: true
      t.inet :ip_address
      t.jsonb :request_data

      t.timestamps
    end
  end
end
