class StatusesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @statuses = Status.all
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    if @status.update(status_params)
      flash[:notice] = "Status successfully updated."
      redirect_to statuses_path
    else
      flash[:alert] = "Unable to update status."
      render :edit
    end
  end

  private

  def status_params
    params.require(:status).permit(:value)
  end
end
