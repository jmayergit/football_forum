class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
  end

  def new
    @bookmark = Bookmark.new
    @post = Post.find(params[:post_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :post_id)
  end
end
