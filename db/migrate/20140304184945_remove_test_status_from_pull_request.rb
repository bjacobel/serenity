class RemoveTestStatusFromPullRequest < ActiveRecord::Migration
  def change
    remove_column :pull_requests, :test_status, :string
  end
end
