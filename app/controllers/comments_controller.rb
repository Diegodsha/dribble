class CommentsController < ApplicationController
before_action :authenticate_user!, only: %i[create destroy]

    def create

        @shot= Shot.find(params[:shot_id])
        @comment = @shots.comments.create(comment_params)
        @comment.user_id = current_user

        if @comment.after_save 
            redirect_to shots_path(@shot), notice:'Shot commented'
        else

            redirect_to shots_path(@shot), alert:'Try again! an error has ocurred'
        end
    end
    

    def destroy
        
        @shot= Shot.find(params[:shot_id])
        @comment = @shots.comments.create(comment_params)
        @comment.destroy
        redirect_to shots_path(@shot)
    end
    
    private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
