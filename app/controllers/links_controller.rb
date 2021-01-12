class LinksController < ApplicationController

    post '/link' do
        if logged_in?
            if  params[:name].strip.empty? || params[:url].strip.empty?
                flash[:message] = "Input Cannot Be Blank"
                redirect '/dashboard'
            else
                @user = current_user 
                @link = Link.new(params)
                if !@link.valid_url?
                    redirect '/dashboard'
                else
                    @link.format_url
                    @link.save
                    @user.links << @link
                end
                flash[:message] = "Saved"
                redirect '/dashboard'
            end
        else
            redirect '/login'
        end
    end
    
    patch '/link' do
        if logged_in?

            if params[:link][:name].find {|p| p.strip.empty?}
                flash[:message] = "Input Cannot Be Blank"
                redirect '/dashboard'
            else
                params[:link][:original_link][:id].each_with_index do |id, index|
                    if @link = current_user.links.find(id)
                        unless @link.name == params[:link][:name][index]
                            @link.name = params[:link][:name][index].strip
                            @link.save
                        end
                        unless @link.url == params[:link][:url][index]
                            @link.url = params[:link][:url][index].strip
                            if @link.valid_url?
                                @link.save
                            end
                        end
                        if params[:link][:check] != nil && params[:link][:check].include?(@link.id.to_s)
                            @link.delete
                        end
                    else
                        flash[:message] = "Unable to update links."
                        redirect '/dashboard'
                    end
                end
                flash[:message] = "Updated"
                redirect '/dashboard'
            end
        else
            redirect '/login'
        end
    end

    delete '/link/:id' do
        @user = current_user
        if logged_in? && @user.links.find(params[:id])
            @link = Link.find(params[:id])
            @link.delete
            flash[:message] = "#{@link.name} Deleted"
            redirect "/#{@user.username}"
        else
            flash[:message] = "Unable To Delete #{@link.name}"
            redirect '/dashboard'
        end
    end
    


end
