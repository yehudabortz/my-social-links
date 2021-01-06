class User < ActiveRecord::Base
    has_secure_password
    has_many :links

    has_many :followers

    has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
    has_many :followers, through: :follower_relationships, source: :follower
    
    has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
    has_many :following, through: :following_relationships, source: :following


    def valid_username?
        if self.username.match(/^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$/)
            true
        else
            false
        end
    end

end