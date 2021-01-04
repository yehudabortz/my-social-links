module Helpers

    def logged_in?
        !!session
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

end