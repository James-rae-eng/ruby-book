class CommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id
        @comment.save!
        redirect_to root_url
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post), status: :see_other
    end
    
    private

    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :body)
    end 
end
