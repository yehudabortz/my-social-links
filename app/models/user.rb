class User < ActiveRecord::Base
    has_secure_password
    has_many :links

    def valid_username?
        if self.username.match(/^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$/)
            true
        else
            false
        end
    end

end