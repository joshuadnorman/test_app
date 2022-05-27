class PagesController < ApplicationController
    
    def home
        redirect_to articles_path if logged_in?
    end
    
    def about
        @active_nav = 'activities'
    end
end
