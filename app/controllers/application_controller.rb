require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
    use Rack::Flash

    include Helpers
    
    configure do
        enable :sessions
        set :session_secret, "password_security"
        set :public_folder, 'app/public'
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
