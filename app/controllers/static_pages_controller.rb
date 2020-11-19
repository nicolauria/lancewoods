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
end
