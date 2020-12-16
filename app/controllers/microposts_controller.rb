class MicropostsController < ApplicationController
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = 'メッセージを投稿しました。'
            redirect_to root_path
        else
            @microposts = current_user.microposts.order('created_at DESC')
            flash.now[:danger] = 'メッセージの投稿に失敗しました。'
            redirect_to root_path
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = 'メッセージを削除しました。'
        redirect_back(fallback_location: root_path)
    end

    private

    def micropost_params
        params.require(:micropost).permit(:content, :practice_time, :practice_content, :practice_category)
    end

    def correct_user
        @micropost = current_user.microposts.find_by(id: params[:id])
        unless @micropost
            redirect_to root_url
        end
    end
end
