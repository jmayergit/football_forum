class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
    @renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(@renderer, {superscript: true, underline: true, strikethrough: true, quote: true, highlight: true})
  end

  def new
    @bookmark = Bookmark.new
    @post = Post.find(params[:post_id])
    @renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(@renderer, {superscript: true, underline: true, strikethrough: true, quote: true, highlight: true})
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark successfully created"
      redirect_to bookmarks_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "Bookmark successfully destroyed"
      redirect_to bookmarks_path
    else
      flash[:alert] = "Unable to destroy bookmark"
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :post_id)
  end
end
