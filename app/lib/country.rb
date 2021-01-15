
class Country

    
    @@all = []

    def initialize(attributes)
        attributes.each do |key, value| 
          self.class.attr_accessor(key)
          self.send(("#{key}="), value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def self.sort_by_country
        all_countries = self.all.reject {|c| c.country == "World"}
        all_countries.sort_by {|c| c.country}
    end

    def self.world_stats
        world_stats = self.all.reject {|c| c.country != "World"}

    end

    def self.create_from_scraper
        covid_data = Scraper.create_and_parse
        covid_data.each do |attributes|
            self.new(attributes)
        end
    end

    def self.find_stats(input)
        self.all.find {|c| c.country == input}
    end

    def self.exclude_world_stats
        self.all.select {|c| c.country != "World"}
    end

    def self.list_countries
        self.exclude_world_stats.collect {|c| c.country}.sort
    end

    def self.find_from_input(input)
        self.find_stats(list_countries[input.to_i - 1])
    end

    #module

    def add_commas_to_int(num)
        split_num = num.to_s.split("")
        if split_num.length <= 3
                split_num.join
        elsif split_num.length == 4
                split_num.insert(1, ",").join
        elsif split_num.length == 5
                split_num.insert(2, ",").join
        elsif split_num.length == 6 
                split_num.insert(3, ",").join
        elsif split_num.length == 7
                split_num.insert(1, ",").insert(5, ",").join
        elsif split_num.length == 8
                split_num.insert(2, ",").insert(6, ",").join
        elsif split_num.length == 9
                split_num.insert(3, ",").insert(7, ",").join
        elsif split_num.length == 10
                split_num.insert(1, ",").insert(5, ",").insert(9, ",").join
        end
    end

end