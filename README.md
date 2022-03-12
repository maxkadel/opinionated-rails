# README
[![CircleCI](https://circleci.com/gh/maxkadel/opinionated-rails.svg?style=svg)](https://app.circleci.com/pipelines/github/maxkadel/opinionated-rails?branch=main&filter=all)

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)

### Dependencies
* Ruby 3.0.3
* Rails 7.0.2
* Bundler 2.2.32
* psql 14.2
* npm 8.5.2
* yarn 1.22.17


### Running in development
#### First time setup
* Clone the repository `git clone git@github.com:maxkadel/opinionated-rails.git`
* Go into application directory `cd opinionated-rails`
* Install gem bundle `bundle install`
* Database creation - ensure you have a Postgres service running
  * `bundle exec rails db:create`
  * `bundle exec rails db:migrate`
* Bring up the application - can change how this occurs in `Procfile.dev`
  * `./bin/dev`
  * Should be able to see the application at http://localhost:3000/

### Running the tests
#### RSpec tests
* All the tests - `bundle exec rspec`
* Single test - `bundle exec rspec spec/path/to/test.rb`

#### Code linter - Rubocop
* To list offenses - `bundle exec rubocop`
* To auto-correct eligible offenses `bundle exec rubocop -a`

### Deployment instructions
This application deploys with Heroku. For info on relevant Heroku commands, see https://devcenter.heroku.com/articles/getting-started-with-rails7#heroku-gems

```bash
git push heroku main
heroku run rake db:migrate
```

### Building this app
* create gemset
```bash
rvm create 3.0.3@opinionated-rails --create
```
* get rails
```bash
gem install rails
```
* Ensure we're using recent versions of dependencies

```bash
$> ruby -v  
ruby 3.0.3p157 // you need at least version 3 here  
$> bundle -v  
Bundler version 2.2.32  
$> npm -v  
8.5.2 // you need at least version 7.1 here  
$> yarn -v  
1.22.17
$> psql --version  
psql (PostgreSQL) 14.2 // lets use a production-ready database locally  
```

* create new rails app
```bash
rails new opinionated-rails --database=postgresql --skip-test --css=bootstrap
```

* go into the application directory
```bash
cd opinionated-rails
```
* Create application database
```bash
bundle exec rake db:create
```
* Create simple Welcome controller, route, and index page in order to be able to see if app is working as expected

* Start application in development mode
```bash
./bin/dev
```
* Initialize git repository for version control
```bash
git init
git add .
git commit -m "init"
git remote add origin git@github.com:maxkadel/opinionated-rails.git
git branch -M main
git push -u origin main
```

* Change application server to passenger
```bash
./bin/dev
```

* Ensure that application can deploy to Heroku
```bash
heroku login
heroku create
echo "web: bundle exec passenger start -p $PORT --max-pool-size 3" >> Procfile
bundle lock --add-platform x86_64-linux
heroku addons:create heroku-postgresql:hobby-dev
heroku buildpacks:add heroku/ruby  
heroku buildpacks:add heroku/nodejs
git add . && git commit -m 'Add Passenger and prepare for production'
git push heroku main
```
* Verify that application looks as expected on Heroku
* Add rspec
  * Add gem to development and test portion of gemfile
```bash
bundle install
rails generate rspec:install
```
* Add rubocop
  * Add gems to development and test portion of gemfile
```bash
bundle install
```
  * Create configuration files - `.rubocop-rails.yml`, `.rubocop.yml`
  * Add Rubocop badge to readme
* Run rubocop autocorrect and get rubocop green
* Add Capybara to enable system tests
* Add CircleCI
