class ForumsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @forums = Forum.all
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(forum_params)

    if @forum.save
      flash[:notice] = "Forum Successfully Created."
      redirect_to forums_path
    else
      render :new
    end
  end

  def show
    @forum = Forum.find(params[:id])
    @topics = @forum.topics.paginate(page: params[:page]).order(:created_at)
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    if @forum.update(forum_params)
      flash[:notice] = "Forum Sucessfully Updated."
      redirect_to forums_path
    else
      render :edit
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    if @forum.destroy
      flash[:notice] = "Forum Successfully Destroyed."
      redirect_to forums_path
    else
      flash[:alert] = "Unable To Destroy Forum."
      redirect_to forums_path
    end
  end

  private

  def forum_params
    params.require(:forum).permit(:name, :private)
  end
end
