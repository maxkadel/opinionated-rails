# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
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
psql (PostgreSQL) 14.2 // let\'s use a production-ready database locally  
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
