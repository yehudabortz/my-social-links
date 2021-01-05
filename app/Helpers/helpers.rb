module Helpers

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        User.find(session[:user_id])
    end

    def valid_credentials?
        !!validate_signup_details
    end
    
    def validate_signup_details
        params[:username].match(/^(?=[a-zA-Z0-9._]{4,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/) && params[:email].match(/[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/) && params[:password].match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/)
    end

    def user_exists?
        !!find_by_username_or_email
    end
    
    def find_by_username_or_email
        User.find_by(:username => params[:username]) || User.find_by(:email => params[:email])
    end


end