serenity
========

Serenity is a independent study project to enable, expand and encourage unit and continuous integration testing in the Northern Bites codebase. Serenity is a Ruby on Rails web app which runs on low-cost hosting (eg, Heroku). When a pull request is submitted to the Northern Bites codebase via Github, Serenity will provision an AWS EC2 instance and check the code out to it, first setting up the Northern Bites' required libraries then running all existing unit tests and unit tests contained in the new code. Members of the Northern Bites Github organization may sign in to Serenity and view this process as it happens, or may instead choose to be notified by email and Github integration about the success of the tests. 

This architecture is inspired heavily by [TravisCI](http://travisci.org) and other continuous integration suites, but I chose to implement from scratch rather than using one of these solutions in order to become familiar with Rails and AWS.  

####Requirements
- Ruby == 2.0.0
- Bundler >= 1.5
- PostgreSQL >= 9.1.12
    - Ubuntu: `apt-get install postgresql libpq-dev`
    - OSX: [Postgres.app](http://postgresapp.com)
- All gems specified in the Gemfile (`bundle install`)


####Secrets
- `application.yml.example` contains an example of the access keys and secrets you will need to configure. The real values are not included in this repository.
- To connect to Amazon, a [public/private keypair are required](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html). Serenity expects a key named `config/default.pem`. You can create and download a key from your AWS dashboard. 

####Tests:  [![Build Status](https://travis-ci.org/bjacobel/serenity.png)](https://travis-ci.org/bjacobel/serenity) 
- Serenity is currently set up to test with Travis CI, but the eventual goal is to test Serenity with Serenity. Whoa, dude. 

