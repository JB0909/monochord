class SongsController < ApplicationController
    def practiced
        @user = User.find_by(:id => params[:id])
        @profile = User.find(params[:id])
    end

    def practicing
        @user = User.find_by(:id => params[:id])
        @profile = User.find(params[:id])
    end

    def wish
        @user = User.find_by(:id => params[:id])
        @profile = User.find(params[:id])
    end

end
