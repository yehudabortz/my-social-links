class UsersController < ApplicationController
    
    get '/signup' do 
            erb :'users/signup'
    end

    post '/signup' do
        if params[:first_name] == "" || params[:last_name] == "" || params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/'
        else
            @user = User.new(params)
            if @user && @user.authenticate(params[:password])
                @user.save
                session[:user_id] = @user.id
                redirect '/dashboard'
            else
                redirect '/login'
            end
        end
    end

    
    get '/login' do 
        erb :'users/login'
    end
    

    #test username yehudabortz 
    # password 123
    post '/login' do 
        @user = User.find_by(:username => params[:username])
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

    get '/logout' do
        session.clear
        redirect '/login'
    end

end
