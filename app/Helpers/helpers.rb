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
            params[:first_name] = params[:first_name].gsub(" ","")
            params[:last_name] = params[:last_name].gsub(" ","")
            params[:username] = params[:username].gsub(" ","").downcase
            params[:email] = params[:email].gsub(" ","").downcase
            params[:password] = params[:password].gsub(" ","")
            
            params[:username].match(/^(?=[a-zA-Z0-9._]{1,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/) && params[:email].match(/[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/) && params[:password].match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/)  
        elsif params[:updated_username] && params[:updated_email]
            params[:updated_username] = params[:updated_username].gsub(" ","").downcase
            params[:updated_email] = params[:updated_email].gsub(" ","").downcase
            
            params[:updated_email].match(/[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/) && params[:updated_username].match(/^(?=[a-zA-Z0-9._]{1,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/)
        elsif params[:username] && params[:password]
            params[:username] = params[:username].gsub(" ","").downcase
            params[:password] = params[:password].gsub(" ","")
            params[:username].match(/^(?=[a-zA-Z0-9._]{1,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/) && params[:password].match(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/)

        elsif params[:updated_username] && params[:updated_email] && !
            params[:updated_username] = params[:updated_username].gsub(" ","").downcase
            params[:updated_email] = params[:updated_email].gsub(" ","").downcase

            params[:updated_email].match(/[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/) && params[:updated_username].match(/^(?=[a-zA-Z0-9._]{1,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/)
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

    def ids_match?
        !!match_params_id_to_current_user
    end

    def match_params_id_to_current_user
        params[:id] == current_user.id.to_s
    end

    def add_to_followed_users_follower_count
        @followed_user.followers_count  = @followed_user.followers_count += 1
        @followed_user.save
    end
    
    def add_to_current_user_following_count
        @user.following_count = @user.following_count += 1
        @user.save
    end
    
    def remove_from_followed_users_follower_count
        @followed_user.followers_count  = @followed_user.followers_count -= 1
        @followed_user.save
    end
    
    def remove_from_current_user_following_count
        @user.following_count = @user.following_count -= 1
        @user.save
    end
    

end