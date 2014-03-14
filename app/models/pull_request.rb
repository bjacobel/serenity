class PullRequest < ActiveRecord::Base
  serialize :payload, JSON
  has_many :builds
end
