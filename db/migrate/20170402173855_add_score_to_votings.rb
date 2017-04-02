class AddScoreToVotings < ActiveRecord::Migration[5.0]
  def change
    add_column :votings, :score, :integer
  end
end
