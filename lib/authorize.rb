module Authorize
  def authorize_user
    authenticate_user!

    unless (current_user.sanctioned?) || (current_user.moderator?)
        flash[:alert] = "You need to be approved before continuing."
        redirect_to forum_path(params[:forum_id]) and return
    end

    unless @forum
      @forum = Forum.find(params[:forum_id])
    end

    if @forum.private
        unless current_user.member?(@forum)
            flash[:alert] = "You need to be a member before continuing."
            redirect_to forum_path(@forum) and return
        end
    end
  end
end
