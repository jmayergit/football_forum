class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def new
    @post = Post.new
    # used to generate submit url, a consequence of nested resources
    @topic = Topic.find(params[:topic_id])
  end

  def create
    @post = Post.new(post_params)
    @topic = Topic.find(params[:topic_id])

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
    # used to generate submit url, a consequence of nested resources
    @topic = Topic.find(params[:topic_id])
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
