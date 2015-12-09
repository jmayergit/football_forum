class TopicsController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update]
  before_action :authenticate_admin!, only: [:index]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    @post = @topic.posts.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic successfully created"
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @op = @topic.posts.first
    @posts = @topic.posts.where("id != ?", @op.id)
  end

  def edit
    @topic = Topic.find(params[:id])
    @post = @topic.posts.first
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      flash[:notice] = "Topic successfully updated"
      redirect_to topic_path(@topic)
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "Topic successfully destroyed"
    else
      flash[:alert] = "Unable to destroy topic"
    end

    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :user_id, :forum_id, posts_attributes: [ :id, :body, :user_id ])
  end

  def authorize
    authenticate_user!
    unless current_user.status.mod?
      authenticate_sanctioned!
      authenticate_member!
    end
  end

  def authenticate_sanctioned!
  end

  def authenticate_member!
  end
end
