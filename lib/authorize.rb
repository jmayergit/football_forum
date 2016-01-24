module Authorize
  def authorize_user_topic
    authenticate_user!

    unless (current_user.sanctioned?) || (current_user.moderator?)
        flash[:alert] = "You need approval before continuing."
        redirect_to forum_path(params[:forum_id]) and return
    end

    @forum = Forum.find(params[:forum_id])

    if @forum.private
        unless current_user.member?(@forum)
            flash[:alert] = "You need membership before continuing."
            redirect_to forum_path(@forum) and return
        end
    end

    if params[:action] == ("edit" || "update")
        @topic = Topic.find(params[:id])
        unless current_user.owns?(@topic)
            flash[:alert] = "You do not have edit permission for this."
            redirect_to forum_path(@forum)
        end
    end
  end

  def authorize_user_post
    authenticate_user!

    @topic = Topic.find(params[:topic_id])
    @forum = @topic.forum

    unless current_user.sanctioned? || current_user.moderator?
      flash[:alert] = "You need approval before continuing."
      redirect_to topic_path(@topic) and return
    end

    if @forum.private?
      unless current_user.member?(@forum)
        flash[:alert] = "You need membership before continuing."
        redirect_to topic_path(@topic) and return
      end
    end

    if params[:action] == ("edit" || "update")
      @post = Post.find(params[:id])
      unless current_user.owns?(@post)
        flash[:alert] = "You do not have edit permission for this."
        redirect_to topic_path(@topic) and return
      end
    end
    
    if @topic.lock
      flash[:alert] = "This topic has been locked."
      redirect_to topic_path(@topic) and return
    end
  end


  def authorize_user_avatar
    authenticate_user!

    @avatar = Avatar.find(params[:id])

    unless current_user == @avatar.user && ( current_user.sanctioned? || current_user.moderator? )
      flash[:alert] = "Unauthorized."
      redirect_to edit_user_registration_path
    end
  end
end
