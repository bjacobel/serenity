#!/usr/bin/env ruby2.0.0-p247

require 'octokit'

github = Octokit::Client.new :client_id => ENV['GITHUB_CLIENT_ID'], :client_secret => ENV['GITHUB_CLIENT_SECRET']

nbites_repos = github.organization_repositories('northern-bites')

nbites_repos.each do |repo|
  Octokit.repository_events(repo.full_name)
end