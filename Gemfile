# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }



    gem 'sinatra'
    gem 'activerecord', '~> 6.0.0', :require => 'active_record'
    gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
    gem 'require_all'
    gem 'thin'
    gem 'bcrypt'
    gem 'rack-flash3'
    gem 'shotgun'
    gem 'faker'
    gem "tux"
    gem 'pry'
    gem 'dotenv'
    
    group :development do
        gem 'sqlite3'
    end
    
    group :production do
        gem 'rake'
        gem 'pg'
        gem 'activerecord-postgresql-adapter'
     end