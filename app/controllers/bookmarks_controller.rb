class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def destroy
  end

  private

  def bookmark_params
    params.permit(:bookmark).require(:user_id, :post_id)
  end
end
