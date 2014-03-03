class AddPrStatusToPullRequest < ActiveRecord::Migration
  def change
    add_column :pull_requests, :pr_status, :string
  end
end
