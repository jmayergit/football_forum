class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Successfully created post"
      redirect_to topic_path(@post.topic)
    else
      render :new
    end
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Successfully updated post"
      redirect_to topic_path(@post.topic)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :topic_id, :body)
  end
end
