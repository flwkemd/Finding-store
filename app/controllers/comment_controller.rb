class CommentController < ApplicationController
  def new

    @_id = params[:id]
  end

  def create
    _id = params[:id]
    _contents = params[:contents]
    
    _post = Post.find(_id)
    
    comment = Comment.new(post: _post, contents: _contents)
    comment.save
    
    redirect_to controller: 'post', action:'list'
    
  end

  def delete
  end
end
