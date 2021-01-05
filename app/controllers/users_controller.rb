class UsersController < ApplicationController
    
    get '/signup' do
        if logged_in?
            redirect '/dashboard'
        else
            erb :'users/signup'
        end
    end

    # !params[:username].match(/^(?=[a-zA-Z0-9._]{4,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/) || !params[:email].match(/[A-Za-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/) || !params[:password].match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/)
    post '/signup' do
        if valid_credentials?
            if  user_exists?
                flash[:message] = "Email Or Username Already Unavailable"
                redirect '/login'
            else
                params[:username] = params[:username].downcase
                params[:email] = params[:email].downcase
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
    
    #test username yehudabortz 
    # password 123
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
        params[:username] = params[:username].downcase
        @user = find_by_username_or_email
        if @user 
            erb :'users/profile'
        else
            redirect '/'
        end
    end

    delete '/logout' do
            session.destroy
            redirect to '/login'
    end

end
