require './config/environment'

class ApplicationController < Sinatra::Base
    use Rack::Flash

    include Helpers
    
    configure do
        enable :sessions
        set :session_secret, ENV['SESSIONS_KEY'] ||= "#{ SecureRandom.hex(20) }"
        set :public_folder, 'app/public'
        set :views, 'app/views'
      end

      binding.pry
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
