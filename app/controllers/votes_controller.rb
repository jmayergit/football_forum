class VotesController < ApplicationController
  before_action :authenticate_user!

  def up
    post = Post.find(params[:post_id])

    # important disctinction for js behavior
    # lies in whether or not the user is
    # casting her vote for the first time
    # or second or more time
    first_vote = !(current_user.voted_on?(post))

    post.vote_by voter: current_user

    # If vote is not registered then either user
    # attempted to cast same vote two times in a row
    # or some unlikely error resulted, preventing a change
    # in the database, either way we need not
    # make changes in the view since it won't be
    # reflected in the database
    registered = post.vote_registered?

    respond_to do |format|
      format.json { render json: {
          vote: {
            type: 'up',
            id: post.id,
            registered: registered,
            first_vote: first_vote
          }
        }}
    end
  end

  def down
    post = Post.find(params[:post_id])

    # important disctinction for js behavior
    # lies in whether or not the user is
    # casting her vote for the first time
    # or not
    first_vote = !(current_user.voted_on?(post))

    post.vote_by voter: current_user, vote: 'bad'

    registered = post.vote_registered?

    respond_to do |format|
      format.json {render json: {
          vote: {
            type: 'down',
            id: post.id,
            registered: registered,
            first_vote: first_vote
          }
        }}
    end
  end
end
