class UsersController < ApplicationController
    
    get '/signup' do
        if logged_in?
            redirect '/dashboard'
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        if params.values.any?("")
            redirect '/'
        else
            if  @user = User.find_by(:username => params[:username])
                flash[:message] = "Username Taken"
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

    get '/:username' do
        params[:username] = params[:username].downcase
        @user = User.find_by(:username => params[:username])
        if @user 
            erb :'users/profile'
        else
            redirect '/'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end

end
