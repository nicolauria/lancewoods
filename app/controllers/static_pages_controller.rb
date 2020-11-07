class StaticPagesController < ApplicationController
    def index
        @discography = Discography.all

        Eventbrite.token = "CWHPF62UVUKFSW273DFW"
        events = Eventbrite::User.owned_events({ user_id: '489192696057' })
        # all_events = events.events
        p events

        # @upcoming_event = user.owned_events.first
        # puts @upcoming_event

        render :index
    end
end
