##original
# ENV['SINATRA_ENV'] ||= "development"

# require 'bundler/setup'
# Bundler.require(:default, ENV['SINATRA_ENV'])


# ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)


configure :development do
    ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
  end
  
  configure :production do
    db = URI.parse(ENV['HEROKU_POSTGRESQL_COBALT_URL'] || 'postgres://localhost/mydb')
  
    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )
  end
require 'timeout'
require 'open-uri'
require_all 'app'