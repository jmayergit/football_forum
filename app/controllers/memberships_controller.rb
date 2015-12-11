class MembershipsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @memberships = Membership.all
  end

  def new
    @membership = Membership.new
    @users = User.all
    @forums = Forum.all
  end

  def create
    @membership = Membership.new(membership_params)

    if @membership.save
      flash[:notice] = "Successfully created new membership"
      redirect_to memberships_path
    else
      render :new
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :forum_id)
  end
end
