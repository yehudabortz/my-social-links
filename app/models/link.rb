class Link < ActiveRecord::Base
    belongs_to :user

    def format_url 
        http = "http://"
        https = "https://"
        if !self.url.downcase.include? http || https
            http + self.url
        else
            self.url
        end
    end

end