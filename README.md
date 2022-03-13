# README
[![CircleCI](https://circleci.com/gh/maxkadel/opinionated-rails.svg?style=svg)](https://app.circleci.com/pipelines/github/maxkadel/opinionated-rails?branch=main&filter=all)

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)

[![Maintainability](https://api.codeclimate.com/v1/badges/b7fa6b1d7864373cf69c/maintainability)](https://codeclimate.com/github/maxkadel/opinionated-rails/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/b7fa6b1d7864373cf69c/test_coverage)](https://codeclimate.com/github/maxkadel/opinionated-rails/test_coverage)

### Dependencies
* Ruby 3.0.3
* Rails 7.0.2
* Bundler 2.2.32
* psql 14.2
* npm 8.5.2
* yarn 1.22.17

### What is this app, anyway?
#### Why?
I have found that sometimes I want to play with making a new Rails app, with the knowledge that it may go somewhere, but then again, it may not. I know from experience that having things like testing and a code linter are easier to have at the beginning of a project, rather than adding them in the middle, but adding them separately for each experiment significantly increases the start-up time and cost, and a low start-up cost is a huge benefit of Rails!

So, this application is intended to be my own opinion on what every Rails app should start with. My hope is that each time I want to do a new experiment, I can clone this repository and have most of the things I want ready to roll, rather than having to add all the testing and other infrastructure from scratch.

#### What's been added
* Postgres database
* Bootstrap for styling
* Rubocop as a code linter
* RSpec for testing
* Capybara for System tests (not currently set up for Selenium, just uses :rack_test)
* Passenger for the application server
* CircleCI for continuous integration
* Procfiles that work for development and deployment with Heroku. I'm not positive how well they would work with other stacks.
* A rudimentary Welcome controller, route, and view, so that we can ensure that the application can deploy and run tests
* SimpleCov for code coverage

#### How to create a new app based on this app
* Decide on a name for your new application - for example purposes, let's call it `my-app`
* Clone the repository `git clone git@github.com:maxkadel/opinionated-rails.git`
* Make the directory for the new application `mkdir my-app`
* Copy the application recursively to new app's location `cp -r opinionated-rails/* my-app`
* Copy hidden files and directories to new app's location (on Mac at least these are not copied with command above, this may differ based on operating system) `cp -r opinionated-rails/.[^.]* my-app`
* Go into the new application directory `cd my-app`
* Remove existing `.git` directory `rm -rf .git` (I don't know if this technically voids some license, but I hereby give you my blessing, maybe just throw a note somewhere about what you started from.)
* Start tracking again - for GitHub, follow these instructions -https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/adding-locally-hosted-code-to-github#adding-a-local-repository-to-github-with-github-cli
* Change names - NOTE: All of the find-and-replaces should use match case
  * Remove this section of the README and the Building This App section
  * replace `maxkadel/opinionated-rails` with `your-gh-organization/my-app`
  * replace `opinionated_rails` with `my_app`
  * replace `OpinionatedRails` with `MyApp`
  * replace `OPINIONATED_RAILS` with `MY_APP`
  * remove the node_modules directory, the yarn.lock file, and the three files in `app/assets/builds`
      * `app/assets/builds/application.css`
      * `app/assets/builds/application.js`
      * `app/assets/builds/application.js.map`
  * Third party integrations
    * CircleCI - enable on your CircleCI dashboard - https://app.circleci.com/projects/project-dashboard/github/YOUR_GH_ORGANIZATION_HERE/
      * Click on "Set Up Project" button
      * Select "Use the `.circleci/config.yml` in my repo" and for "From which branch" select "main"
    * Go to CodeClimate and add your repository https://codeclimate.com/oss/dashboard
    * Go to https://codeclimate.com/repos/YOUR_REPO_ID_HERE/settings/test_reporter and copy your application's Test Reporter ID
    * Go to the project settings on CircleCI and add a new environment variable `CC_TEST_REPORTER_ID` and for the value put the Test Reporter ID you copied in the previous step.
    * Go to https://codeclimate.com/github/YOUR_GH_ORGANIZATION_HERE/YOUR_APP_NAME_HERE/badges#test-coverage-markdown Replace the badges in this readme with those (the CircleCI ones should have been taken care of with the copy-paste steps above)
* If you want to use Heroku for deploys, run
```bash
heroku create
heroku addons:create heroku-postgresql:hobby-dev
heroku buildpacks:add heroku/ruby  
heroku buildpacks:add heroku/nodejs
```
* You can see what these changes look like with this example - https://github.com/maxkadel/my-app/compare/main...changing_app_name

### Running in development
These instructions are for if you want to play with this app as-is, without trying to create your own based on it.

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

#### Handy command line checks
* Validate CircleCI configuration without having to commit it first
```bash
circleci config validate
```
* Run CodeClimate in debug mode, without reporting
```bash
CODECLIMATE_DEBUG=1 codeclimate analyze
```
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
* Add SimpleCov and CodeClimate for coverage and other metrics
