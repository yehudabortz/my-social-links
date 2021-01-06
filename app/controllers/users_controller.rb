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
                @user = User.new(params)
                if @user && @user.authenticate(params[:password])
                    @user.save
                    session[:user_id] = @user.id
                    redirect '/dashboard'
                else
                    redirect '/login'
                end
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
            redirect '/'
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

    get '/:username' do
        downcase_username
        @user = find_by_username_or_email
        if @user 
            erb :'users/profile'
        else
            flash[:message] = "#{params[:username]} Does Not Exist"
            redirect '/'
        end
    end

    delete '/logout' do
        session.destroy
        redirect to '/login'
    end

end
