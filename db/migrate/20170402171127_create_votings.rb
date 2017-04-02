class CreateVotings < ActiveRecord::Migration[5.0]
  def change
    create_table :votings do |t|
      t.integer :user_id, null: false
      t.integer :url_id, null: false
    end
    add_index(:votings, :user_id)
    add_index(:votings, :url_id)
  end
end
