#original
ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require 'dotenv'
Dotenv.load

require 'timeout'
require 'open-uri'
require 'sinatra'
require 'rack-flash'

require_all 'app'

configure :development do
    ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)
  end
  
configure :production do
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
 
    ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
      )
 end