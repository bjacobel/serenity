class RemoveShitFromPullRequest < ActiveRecord::Migration
  def change
    remove_column :pull_requests, :creator, :string
    remove_column :pull_requests, :created, :string
  end
end
