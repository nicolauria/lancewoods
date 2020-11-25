class DashboardController < ApplicationController
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
        
        # render plain: 'MF000'
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

    private

    def event_params
        params.permit(:name, :description, :date, :price, :event_url, :city, :location)
    end
end
