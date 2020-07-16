# README
## Rails Engine
### Mod 3 Solo Project: Exposing and API
#### Scenario:
You are working for a company developing an E-Commerce Application. Your team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. Your job is to expose the data that powers the site through an API that the front end will consume.

### Setup

**Repos**
### Rails Engine
#### (Back End that exposes API)
```
$ git clone git@github.com:janegreene/rails_engine.git
$ cd rails_engine
$ bundle install
```
**Database**  
```
$ bundle exec rake import
```
**Testing**
```
$ bundle exec rspec
```

### Rails Driver
#### (Front End that consumes this project)
Rails Engine will run on localhost port 3000 so Rails Driver should be set to run on 3001.
```
$ git clone git@github.com:janegreene/rails_driver.git
$ cd rails_driver
$ bundle install
$ rails s -p 3001
```
#### to run the harness
```
bundle exec rspec spec/features/harness_spec.rb
```

### Versions
```
  Rails 5.1.7
  Ruby 2.5.3
```
### Schema
<p align="center">
 <img src="https://i.imgur.com/3YaDZp4.jpg">
</p>
