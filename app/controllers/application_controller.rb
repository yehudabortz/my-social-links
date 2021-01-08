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
        if logged_in?
            @users = User.all
            erb :index
        else
            erb :index_not_logged_in
        end
    end

end
