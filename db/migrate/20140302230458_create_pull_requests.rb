class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.string :creator
      t.datetime :created
      t.integer :github_id
      t.string :test_status
      t.boolean :passing

      t.timestamps
    end
  end
end
