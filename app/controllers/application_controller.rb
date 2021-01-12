require './config/environment'

class ApplicationController < Sinatra::Base
    use Rack::Flash

    include Helpers
    
    configure do
        enable :sessions
        set :session_secret, ENV['SESSION_KEY'] ||= "super_secret"
        set :public_folder, 'app/public'
        set :views, 'app/views'
      end

    get '/' do 
        @users = User.all
        if logged_in?
            erb :index
        else
            erb :index_not_logged_in
        end
    end

    not_found do
        erb :not_found
      end

end
