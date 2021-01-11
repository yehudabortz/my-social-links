require './config/environment'

class ApplicationController < Sinatra::Base
    use Rack::Flash

    include Helpers
    
    configure do
        enable :sessions
        set :session_secret, "89553c5b54e507f47ab401d303b2f6f5264fd0e8af1f1c68595e23e369a61443e198646f4bef44e446aeaf6be786e9b0ac3f75cb465e3ff8f89a67b80635f5bf"
        set :public_folder, 'app/public'
        set :views, 'app/views'
      end

    get '/' do 
        if logged_in?
            @users = User.all
            erb :index
        else
            erb :index_not_logged_in
        end
    end

    not_found do
        erb :not_found
      end

end
