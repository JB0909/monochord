class UsersController < ApplicationController
    before_action :authenticate_user!

    def following
        @title = "Following"
        @user  = User.find(params[:id])
        #@users = @user.following.paginate(page: params[:page])
        render 'show_follow'
    end
    
    def followers
        @title = "Followers"
        @user  = User.find(params[:id])
        #@users = @user.followers.paginate(page: params[:page])
        render 'show_follow'
    end

    def practicing
    end

    def wish
    end
    
end
