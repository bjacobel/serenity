#!/usr/bin/env ruby2.0.0-p247

require 'octokit'

# requires the env variables GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET to be set on the machine
github = Octokit::Client.new :client_id => ENV['GITHUB_CLIENT_ID'], :client_secret => ENV['GITHUB_CLIENT_SECRET']

# get all our repos - Serenity could be expanded to code outside 'nbites' later
# serenity could even test itself. mind blown
nbites_repos = github.organization_repositories('northern-bites')

# for now, just find the nbites repo
codebase = nbites_repos.select{|repo| repo.name == 'nbites'}[0]

events = Octokit.repository_events(codebase.full_name)
pull_requests = events.select{|event| event.type == "PullRequestEvent"} 
pull_requests.each {|pr| puts pr.inspect + "\n\n"}