class Link < ActiveRecord::Base
    belongs_to :user

    def format_url 
        http = "http://"
        self.url = self.url.gsub(" ","")
        if self.url.downcase.start_with?("http://www.") || self.url.downcase.start_with?("https://www.") || self.url.downcase.start_with?("http://") || self.url.downcase.start_with?("https://")
            self.url
        else
            http + self.url
        end
    end

    def valid_url?
        begin
        Timeout::timeout(1) do 
            response = open("#{self.format_url}").status 
            if response == ["200","OK"]
                true
            end
        end
        rescue => error
            false
        end
    end

end