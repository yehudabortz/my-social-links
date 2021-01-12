require './config/environment'

class ApplicationController < Sinatra::Base
    use Rack::Flash

    include Helpers
    
    configure do
        enable :sessions
        set :session_secret, ENV['SESSION_KEY']
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
