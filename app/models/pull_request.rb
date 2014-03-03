class PullRequest < ActiveRecord::Base
    serialize :payload, JSON
end
