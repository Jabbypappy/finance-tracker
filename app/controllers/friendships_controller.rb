class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Following user #{friend.full_name}"
    else
      flash[:alert] = "There was something wrong with the tracking request"
    end
    redirect_to friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Stopped following #{friend.full_name}"
    redirect_to friends_path
  end
end
