class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build comments_params
    @comment.user_id = current_user.id
    if @comment.save
      render json: @comment.to_json
    else
      render json: {}
    end
  end

private

  def find_commentable
    return params[:commentable_type].classify.constantize.find params[:commentable_id]
  end

  def comments_params
    params.permit(:content, :commentable_id, :commentable_type)
  end


end
