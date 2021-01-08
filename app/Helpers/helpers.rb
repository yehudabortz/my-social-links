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
        if params[:username] && params[:email] && params[:password]
            params[:username].match(/^(?=[a-zA-Z0-9._]{1,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/)
            params[:email].match(/[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/)
            params[:password].match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/)
        elsif params[:updated_username] && params[:updated_email]
            params[:updated_username].match(/^(?=[a-zA-Z0-9._]{1,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/)
            params[:updated_email].match(/[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/)
        end
    end

    def user_exists?
        !!find_by_username_or_email
    end

    def username_available?
        !find_by_updated_username
    end

    def email_available?
        !find_by_updated_email
    end
    
    def find_by_username_or_email
        User.find_by(:username => params[:username]) || User.find_by(:email => params[:email])
    end

    def find_by_updated_username
        User.find_by(:username => params[:updated_username])
    end

    def find_by_updated_email
        User.find_by(:email => params[:updated_email])
    end

    def downcase_username
        if params[:username] && params[:updated_username]
            params[:username] = params[:username].downcase
            params[:updated_username] = params[:updated_username].downcase
        elsif params[:username]
            params[:username] = params[:username].downcase
        end
    end
    
    def downcase_username_and_email
        downcase_username
        if params[:email]
            params[:email] = params[:email].downcase
        elsif params[:updated_email]
            params[:updated_email] = params[:updated_email].downcase
        end
    end

    def ids_match?
        !!match_params_id_to_current_user
    end

    def match_params_id_to_current_user
        params[:id] == current_user.id.to_s
    end





end