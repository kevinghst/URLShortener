class CreateUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :urls do |t|
      t.string :long_url, null: false
      t.string :short_url, null: false
      t.integer :clicks, null: false
      t.timestamps
    end
    add_index(:urls, :long_url, unique: true)
    add_index(:urls, :short_url, unique: true)
  end
end
