class AddPayloadToPullRequest < ActiveRecord::Migration
  def change
    add_column :pull_requests, :payload, :binary
  end
end
