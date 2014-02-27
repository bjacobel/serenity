#!/usr/bin/env ruby2.0.0-p247

require 'octokit'

# requires the env variables GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET to be set on the machine
github = Octokit::Client.new :client_id => ENV['GITHUB_CLIENT_ID'], :client_secret => ENV['GITHUB_CLIENT_SECRET']

# get all our repos - Serenity could be expanded to code outside 'nbites' later
# serenity could even test itself. mind blown
nbites_repos = github.organization_repositories('northern-bites')

# for now, just find the nbites repo
codebase = nbites_repos.select{|repo| repo.name == 'nbites'}[0]

# crappy solution 

handled_pulls = []

while true

  events = Octokit.repository_events(codebase.full_name)
  pr_events = events.select{|event| event.type == "PullRequestEvent"}

  pull_requests = []

  pr_events.each do |pr_ev|
  	if not handled_pulls.include?(pr_ev.number)
	    pull_requests.push(pr_ev.pull_request)
	end
  end

  sleep 300
end