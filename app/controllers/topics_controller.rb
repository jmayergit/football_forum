class TopicsController < ApplicationController
  before_action :authorize_user!, only: [:new, :create, :edit, :update]
  before_action :authenticate_owner!, only: [:edit, :update]
  before_action :authenticate_admin!, only: [:index]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    @post = @topic.posts.new
    # used to generate submit url for form
    @forum = Forum.find(params[:forum_id])
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic successfully created."
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
    # used to generate submit url for form
    @forum = Forum.find(params[:forum_id])
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      flash[:notice] = "Topic successfully updated."
      redirect_to topic_path(@topic)
    else
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "Topic successfully destroyed."
    else
      flash[:alert] = "Unable to destroy topic!"
    end

    redirect_to topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :user_id, :forum_id, posts_attributes: [ :id, :body, :user_id ])
  end

  def authorize_user!
    authenticate_user!
    unless current_user.status.mod?
      authenticate_sanctioned!
      authenticate_member!
    end
  end

  def authenticate_sanctioned!
    if current_user.status.unsanctioned?
      flash[:alert] = "You have not been cleared to create topics."
      redirect_to forum_path(get_forum)
    end
  end

  def authenticate_member!
    forum = get_forum
    if forum.private?
      unless is_member?(forum.id)
        flash[:alert] = "You do not have membership to this forum."
        redirect_to forum_path(forum)
      end
    end
  end

  def authenticate_owner!
    if current_user.id != get_user_id(get_topic)
      flash[:alert] = "Unable to Edit Topic."
      redirect_to forum_path(get_forum)
    end
  end

  def is_member?(forum_id)
    memberships = current_user.memberships
    memberships.each do |membership|
      return true if membership.forum_id == forum_id
    end

    false
  end

  def get_forum
    return Forum.find(params[:forum_id])
  end

  def get_topic
    return Topic.find(params[:id])
  end

  def get_user_id(topic)
    return topic.user.id
  end
end
