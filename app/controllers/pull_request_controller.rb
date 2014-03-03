class PullRequestController < ApplicationController
skip_before_filter :verify_authenticity_token, only: [:new]

  def index
    @pulls = PullRequest.all
  end

  def new
    @pull = PullRequest.new
    @pull.payload = params
    @pull.save()
  end
end
