class UsersController < ApplicationController
    
    get '/signup' do
        if logged_in?
            redirect '/dashboard'
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        if valid_credentials?
            if  user_exists?
                flash[:message] = "Email Or Username Already Unavailable"
                redirect '/login'
            else
                downcase_username_and_email
                @user = User.create(params)
                @user.following_count = 0
                @user.follower_count = 0
                @user.save
                session[:user_id] = @user.id
                redirect '/dashboard'
            end
        else
            flash[:message] = "Invalid Sign Up Details"
            redirect '/signup'
        end
    end
 
    get '/login' do
        if logged_in?
            redirect '/dashboard'
        else
            erb :'users/login'
        end
    end
    
    post '/login' do 
        @user = find_by_username_or_email
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/dashboard'
        else
            flash[:message] = "Unable to log in. Try Again!"
            redirect '/login'
        end
    end
    
    get '/dashboard' do
        if logged_in?
            @user = current_user
            erb :'users/dashboard'
        else
            redirect '/login'
        end
    end
    
    get  '/feed' do 
        if logged_in?
            @user = current_user
            erb :"users/feed"
        else
            flash[:message] = "Please log in to view your feed."
            redirect '/'
        end
    end
    
    get '/:username' do
        downcase_username
        @user = find_by_username_or_email
        if @user 
            erb :'users/profile'
        else
            redirect '/'
        end
    end

    patch '/:username/edit' do 
        if logged_in?
            if ids_match? && valid_credentials?
                downcase_username_and_email
                if username_available? && email_available?
                    current_user.update(username: params[:updated_username])
                    current_user.update(email: params[:updated_email])
                    flash[:message] = "Profile Updated"
                    redirect '/dashboard'
                elsif username_available? && params[:updated_email] == current_user.email
                    current_user.update(username: params[:updated_username])
                    flash[:message] = "Username Updated"
                    redirect '/dashboard'
                elsif email_available? && params[:updated_username] == current_user.username
                    current_user.update(email: params[:updated_email])
                    flash[:message] = "Email Updated"
                    redirect '/dashboard'
                elsif !username_available? && !email_available?
                    flash[:message] = "Unable to update profile."
                    redirect '/dashboard'
                else
                    flash[:message] = "Unable to update profile."
                    redirect '/dashboard'
                end
            else
                flash[:message] = "Unable to update profile."
                redirect '/dashboard'
            end
        else
            flash[:message] = "Please log in to make changes to your profile."
            redirect '/login'
        end
    end

    get '/:username/follow' do 
        if logged_in? && user_exists?
            flash[:message] = "You Must Clock The Follow Button To Follow @#{params[:username]}"
            redirect "/#{params[:username]}"
        else
            flash[:message] = "Unable To Follow @#{params[:username]}"
            redirect "/#{params[:username]}"
        end
    end

    post '/:username/follow' do 
        if logged_in? && user_exists? && params[:username]
            if params[:username] == current_user.username
                flash[:message] = "Action Not Allowed"
                redirect "/"
            else
                @followed_user = find_by_username_or_email
                @user = current_user
                if !current_user.following.include?(@followed_user)
                    @user.following << @followed_user
                    add_to_follower_count
                    add_to_following_count
                    redirect "/"
                else
                    flash[:message] = "Already Following @#{params[:username]}"
                    redirect "/#{params[:username]}"
                end
            end
        else
            flash[:message] = "Please login to follow @#{params[:username]}"
            redirect "/login"
        end
    end
    
    delete '/:username/follow' do 
        if logged_in? && user_exists?
            followed_user = find_by_username_or_email

            if current_user.following.include?(followed_user)
                current_user.following.delete(followed_user)
                flash[:message] = "Unfollowed @#{params[:username]}"
                redirect "/#{params[:username]}"
            else
                flash[:message] = "Unable to perform this action."
                redirect "/#{params[:username]}"
            end
        else
            flash[:message] = "Unable to perform this action."
            redirect "/#{params[:username]}"
        end
    end

    delete '/logout' do
        session.destroy
        redirect to '/login'
    end
    
    delete '/:username' do 
        if params[:user][:username] == current_user.username
            @user = current_user
            @user.delete
            session.destroy
            redirect '/'
        else
            redirect '/dashboard'
            flash[:message] = "Something Went Wrong"
        end
    end


end
