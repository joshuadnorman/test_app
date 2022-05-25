class SessionsController < ApplicationController
def new
    if session[:user_id]
        user = User.find(session[:user_id])
        redirect_to user
    else 
    end 
end 

def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) 
        session[:user_id] = user.id
        flash[:notice] = "Successfully Logged In"
        redirect_to user
    else 
        flash.now[:alert] = "Login Details incorrect"
        render 'new'
    end
end 

def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
end 

end 