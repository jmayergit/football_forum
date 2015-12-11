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
  end
end
