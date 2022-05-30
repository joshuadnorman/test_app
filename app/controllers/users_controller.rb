class UsersController < ApplicationController
    before_action :set_user , only: [:show,:edit,:update,:destroy]
    before_action :require_user, except: [:show,:index,:new,:create]
    before_action :require_same_user, only: [:edit,:update,:destroy]
    
    def show
        
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end 
    
    def new
        @user = User.new
    end 
    
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end 
    
    def edit
        
    end 
    
    def update
        if @user.update(user_params)
            flash[:notice] = "#{@user.username} has been successfully updated"
            redirect_to @user
        else
            render 'edit'
        end 
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
    
    def destroy
        @user.destroy
        debugger
        session[:user_id] = nil if @user == current_user #this has to happen to clear the cookie session which will cause confusion to the user 
        flash[:notice] = "Account and articles have been deleted"
        redirect_to root_path
    end 
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end 
    
    def set_user
        @user = User.find(params[:id])
    end 
    
    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can only edit your own profile"
            redirect_to @user
        end 
    end 
end 