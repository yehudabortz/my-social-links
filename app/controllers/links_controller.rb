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
                    @link = Link.find(id)
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
                end
                flash[:message] = "Updated"
                redirect '/dashboard'
            end
        else
            redirect '/login'
        end
    end

    delete '/link' do
        @user = current_user
        if logged_in? && @user.links.find(params[:link][:id])
            @link = Link.find(params[:link][:id])
            @link.delete
            flash[:message] = "#{@link.name} Deleted"
            redirect '/dashboard'
        else
            flash[:message] = "Updated"
            flash[:message] = "Unable To Delete #{@link.name}"
            redirect '/dashboard'
        end
    end
    


end
