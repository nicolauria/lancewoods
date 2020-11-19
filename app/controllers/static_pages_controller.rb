class StaticPagesController < ApplicationController
    def index
        @discography = Discography.all
        @events = Event.all
        @products = Product.all 

        render :index
    end

    def newsletter
        MyMailer.send_email(name: params[:name], phone: params[:phone], email: params[:email], message: params[:message]).deliver
        
        render plain: 'MF000'
    end

    def product
        @product = Product.find(params[:id])
        @products = Product.all

        render :product
    end

    def add_to_cart
        p params

        # render :cart
    end
end
