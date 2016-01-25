class PostsController < ApplicationController
  include Authorize

  before_action :authorize_user_post, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!

  def index
    @posts = Post.where(user_id: current_user.id).paginate(page: params[:page]).order(:created_at)
    @renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(@renderer, {superscript: true, underline: true, strikethrough: true, quote: true, highlight: true})
  end

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
