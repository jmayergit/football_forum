class TopicsController < ApplicationController
  include Authorize

  # Filters have access to the request, response, and all the instance variables
  # set by other filters in the chain or by the action (in the case of after filters).
  before_action :authorize_user_topic, only: [:new, :create, :edit, :update]
  before_action :authorize_mod!, only: [:lock, :sticky]
  after_action :mark_topic_as_read!, only: [:show]

  def index
    @topics = Topic.search(params[:search])
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
    @posts = @topic.posts.paginate(page: params[:page]).order(:created_at)

    @renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(@renderer, {superscript: true, underline: true, strikethrough: true, quote: true, highlight: true})
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

  def lock
    @topic = Topic.find(params[:id])

    if @topic.update(lock_params)
      respond_to do |format|
        format.json { render json: @topic  }
      end
    else
    end

  end

  def sticky
    @topic = Topic.find(params[:id])

    if @topic.update(sticky_params)
      respond_to do |format|
        format.json { render json: @topic}
      end
    else
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :user_id, :forum_id, posts_attributes: [ :id, :body, :user_id ])
  end

  def lock_params
    params.require(:topic).permit(:lock)
  end

  def sticky_params
    params.require(:topic).permit(:sticky)
  end

  def mark_topic_as_read!
    unless !(user_signed_in?) || (current_user.have_read?(@posts.last))
      @posts.last.mark_as_read! for: current_user
    end
  end

  def authorize_mod!
    unless user_signed_in?
      flash[:alert] = "Only mods can mod."
      redirect_to root_path and return
    end
    
    unless current_user.moderator?
      flash[:alert] = "Only mods can mod."
      redirect_to root_path
    end
  end
end
