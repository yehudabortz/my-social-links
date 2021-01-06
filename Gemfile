# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }


group :production do
    gem 'sinatra'
    gem 'activerecord', '~> 6.0.0', :require => 'active_record'
    gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
    gem 'require_all'
    gem 'sqlite3'
    gem 'thin'
    gem 'bcrypt'
    gem 'rack-flash3'
    gem "pg"
  end
  
  group :development, :test do
    gem "sqlite3"
    gem 'rake'
    gem 'shotgun'
    gem 'faker'
    gem "tux"
    gem 'pry'
  end
