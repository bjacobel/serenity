class RemovePrStatusFromPullRequest < ActiveRecord::Migration
  def change
    remove_column :pull_requests, :pr_status, :string
  end
end
