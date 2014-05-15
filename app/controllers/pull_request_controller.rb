class PullRequestController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:new]

  def index
    @pulls = PullRequest.all
  end

  def new
    @pull = PullRequest.new
    
    begin
      @pull.payload     = params
      @pull.github_id   = params[:pull_request][:id]
      @pull.number      = params[:number]
      @pull.creator_id  = params[:sender][:id]
      @pull.title       = params[:pull_request][:title]
      @pull.action      = params[:action]
    rescue  # something's wrong with the JSON github sent over
      raise Exception.new("Problem with the JSON; didn't find expected fields")
    else
      @pull.save()

      Delayed::Job.enqueue AwsJob.new(@pull)
    end
  end
end
