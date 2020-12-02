class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
    
        if @user.save
          sign_in(@user)
          redirect_to dashboard_url
        else
        #   flash.now[:errors] = @user.errors.full_messages
          render json: 'user not created'
        end
      end
    
    private
    def user_params
        params.permit(:username, :password)
    end
end
