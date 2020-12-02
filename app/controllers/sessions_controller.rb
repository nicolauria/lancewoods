class SessionsController < ApplicationController
    before_action :require_signed_out!, only: [:new, :create]

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:username],
            params[:password]
        )

        if @user
            sign_in(@user)
            redirect_to dashboard_url
        else
            flash.now[:errors] = 'Invalid credentials...'
            render :new
        end
    end

    def destroy
        sign_out
        redirect_to login_url
    end
end
