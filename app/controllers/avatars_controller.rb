class AvatarsController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def edit
    @avatar = Avatar.new()
  end

  def update
  end
end
