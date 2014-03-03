class AddShitToPullRequest < ActiveRecord::Migration
  def change
    add_column :pull_requests, :number, :integer
    add_column :pull_requests, :title, :string
    add_column :pull_requests, :creator_id, :integer
    add_column :pull_requests, :action, :string
  end
end
