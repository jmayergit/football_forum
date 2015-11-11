class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic successfully created"
      redirect_to topics_path
    else
      redner :new
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:subject)
  end
end
