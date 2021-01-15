class CovidController < ApplicationController
    get '/covid/data' do 
        erb :'covid/index'
    end



end