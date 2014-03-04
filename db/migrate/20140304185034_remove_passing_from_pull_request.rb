class RemovePassingFromPullRequest < ActiveRecord::Migration
  def change
    remove_column :pull_requests, :passing, :boolean
  end
end
