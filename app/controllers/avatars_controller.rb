class AvatarsController < ApplicationController
  include Authorize

  before_action :authenticate_admin!, only: [:index]
  before_action :authorize_user_avatar, except: [:index]

  def index
    @avatars = Avatar.all()
  end

  def edit
    @avatar = Avatar.find(params[:id])
  end

  def update
    @avatar = Avatar.find(params[:id])

    if !params[:avatar][:image]
      flash[:alert] = "Unable to update avatar."
      redirect_to edit_user_registration_path and return
    end

    if @avatar.update(avatar_params)
      flash[:notice] = "Avatar successfully updated!"
      redirect_to edit_user_registration_path
    else
      flash[:alert] = "Unable to update Avatar."
      render :edit
    end
  end


  private

  def avatar_params
    params.require(:avatar).permit(:image, :id)
  end
end
