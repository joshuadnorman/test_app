class UsersController < ApplicationController
    def new
        @user = User.new
    end 
    
    def create
        @user = User.new(user_params)
        if (@user.save)
            flash[:notice] = "Welcome to the alpha blog #{@user.username} , sign up successful"
            redirect_to articles_path
        else
            render 'new' #this new is an action within this controller
        end 
    end 
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end 
end 