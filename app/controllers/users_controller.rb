class UsersController < ApplicationController
    
    get '/signup' do 
        erb :'users/signup'
    end

    post '/signup' do
        if logged_in?
            redirect '/login'
        else
            if params[:first_name] == "" || params[:last_name] == "" || params[:username] == "" || params[:email] == "" || params[:password] == ""
                redirect '/signup'
            else
                if !User.find_by(username: params[:username]) || !User.find_by(email: params[:email])
                    @user = User.create(params)
                    if @user && @user.authenticate(params[:password])
                        session[:user_id] = @user.id
                        redirect '/dashboard'
                    else
                        redirect '/login'
                    end
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

    post '/login' do 

    end

    get '/dashboard' do
        if logged_in?
            @user = (first_name: "Yehuda")
            erb :'users/dashboard'
        else
            redirect '/login'
        end
    end

    get '/logout' do

    end

end
