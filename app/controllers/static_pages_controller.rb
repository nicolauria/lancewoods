class StaticPagesController < ApplicationController
    def index
        @discography = Discography.all
        @events = Event.all
        @products = Product.all 

        render :index
    end
end
