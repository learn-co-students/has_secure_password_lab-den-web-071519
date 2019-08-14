class UsersController < ApplicationController
    def new
    end

    def create
        @user = User.create(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to(
                controller: 'users',
                action: 'welcome'
            )
        else
            redirect_to(
                controller: 'users',
                action: 'new'
            )
        end
    end

    def welcome
        require_logged_in
        @user = User.find_by(id: session[:user_id])
    end

 private

    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end

end
