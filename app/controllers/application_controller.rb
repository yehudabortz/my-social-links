require './config/environment'

class ApplicationController < Sinatra::Base
    include Helpers

    configure do
        enable :sessions
        set :session_secret, "password_security"
        set :public_folder, 'public'
        set :views, 'app/views'
      end

    get '/' do 
        @users = User.all
        erb :index
    end

end
