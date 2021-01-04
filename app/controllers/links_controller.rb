class LinksController < ApplicationController
    

    post '/link' do 
        params.to_s
        #{"name"=>"TikTok", "url"=>"https://www.tiktok.com/@yehudabortz"}
        if !logged_in? || params.values.any?("")
            redirect '/dashboard'
        else
            @user = current_user
            @user.links << @link = Link.create(params)
            redirect '/dashboard'
        end
    end

end
