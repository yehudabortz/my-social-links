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
    
    patch '/link' do
        params[:original_link][:id].each_with_index do |id, index|
            @link = Link.find(id)
            unless @link.name == params[:link][:name][index]
                @link.name = params[:link][:name][index]
                @link.save
            end
            unless @link.url == params[:link][:url][index]
                @link.url = params[:link][:url][index]
                unless @link.valid_url?
                    @link.save
                end
            end
        end
        redirect '/dashboard'
    end
    

    
end
