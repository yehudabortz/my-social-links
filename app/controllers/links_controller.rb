class LinksController < ApplicationController
    


    post '/link' do 
    
        if  params.values.any?("")
            redirect '/dashboard'
        else
            @user = current_user 
            @link = Link.new(params)
            if !@link.valid_url?
                redirect '/dashboard'
            else
                @link.save
                @user.links << @link
            end
            redirect '/dashboard'
        end
    end

end
