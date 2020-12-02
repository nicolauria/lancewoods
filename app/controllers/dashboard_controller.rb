class DashboardController < ApplicationController
    before_action :require_signed_in!
    
    def index
        @events = Event.all
        @products = Product.all
        render :index
    end

    def edit_event_form
        @event = Event.find(params[:id])
        render :edit_event_form
    end

    def edit_event
        event = Event.find(params[:id])
        event.update(event_params)
        
        redirect_to :dashboard
    end

    def add_event_form
        @event = Event.new
        render :add_event_form
    end

    def add_event
        Event.create(event_params)
        redirect_to :dashboard
    end

    def delete_event
        event = Event.find(params[:id])
        event.delete
        redirect_to :dashboard
    end

    def edit_product_form
        @product = Product.find(params[:id])
        render :edit_product_form
    end

    def edit_product
        product = Product.find(params[:id])
        product.update(product_params)

        redirect_to :dashboard
    end

    def delete_product
        product = Product.find(params[:id])
        product.delete
        redirect_to :dashboard
    end

    def add_product_form
        render :add_product_form
    end

    def add_product
        Product.create(product_params)
        redirect_to :dashboard
    end

    private

    def event_params
        params.permit(:name, :description, :date, :price, :event_url, :city, :location)
    end

    def product_params
        params.permit(:name, :price, :description, :image1, :image2, :image3, :thumbnail, :popular, :category)
    end
end
