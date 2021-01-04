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
        if logged_in?
            @user = current_user
        end
        erb :index
    end

end
