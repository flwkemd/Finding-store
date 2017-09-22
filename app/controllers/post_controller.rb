class PostController < ApplicationController
  
  # skip_before_filter :require_login, :only => [:list]
  before_action :authenticate_user!, except: [ :list ]
  
  ### CREATE START
  def create
    _author = params[:author]
    _title = params[:title]
    _contents = params[:context]
    
    post = Post.new(author: _author, title: _title, context: _contents)
    post.user = current_user
    post.save
    
    redirect_to controller: 'post', action:'list'
  end

  def new
    
  end
  ### CREATE END
  
  ### READ
  def list
    @posts = Post.all
  end
  
  ### UPDATE
  def modify
    _id = params[:id]
    @post = Post.find(_id)

    authorize_action_for @post

  end
  
  def update
    _id = params[:id]
    _author = params[:author]
    _title = params[:title]
    _contents = params[:context]
    
    post = Post.find(_id)
    authorize_action_for post
  
    post.author = _author
    post.title = _title
    post.context = _contents
    
    post.save
    
    redirect_to controller: 'post', action:'list'
  end
  
  ### DELETE
  def delete
    _id = params[:id]
    
    @post = Post.find(_id)
    authorize_action_for @post
        
    @post.destroy
    
    redirect_to controller: 'post', action:'list'
    
  end
end
