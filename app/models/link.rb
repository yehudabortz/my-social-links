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

    def valid_url?
        begin
        response = Timeout::timeout(0.3) do 
            open("#{self.format_url}").status 
            if response == ["200","OK"]
                true
            end
        end
        rescue => error
            false
        end
    end

end