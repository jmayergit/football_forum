class TopicsController < ApplicationController
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
      redirect_to topics_path
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @op = @topic.posts.first
  end

  def edit
    @topic = Topic.find(params[:id])
    @post = @topic.posts.first
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:notice] = "Topic successfully updated"
      redirect_to topics_path
    else
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :user_id, posts_attributes: [ :id, :body, :user_id ])
  end
end
