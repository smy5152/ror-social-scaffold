class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: 'Woohoo!!! You invited a friend. Dont you have enough already?'
    else
      redirect_to users_path, alert: 'Could not invite this friend.  Ha! Ha!'
    end
  end

  def update
    friend = User.find_by(id: params[:user_id])
    current_user.confirm_friend(friend)
    redirect_to user_path, notice: "#{friend.name} is now your friend. Congrats :P"
  end

  def destroy
    friend = User.find_by(id: params[:user_id])
    current_user.reject_friend(friend)
    redirect_to user_path, notice: "Rejected #{friend.name}'s Friend Request. Why though?"
  end
end
