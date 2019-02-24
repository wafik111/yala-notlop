class FriendsController < ApplicationController

    def index
        @friends = current_user.friends
        p @friends
        @requested_friends = current_user.requested_friends
        @pending_friends = current_user.pending_friends
    end

    def create
        @user = current_user
        @requested_friend = User.find_by(name: params[:name])
        if @requested_friend and not @user.friends_with?(@requested_friend)
            @user.friend_request(@requested_friend)
            @requested_friend.friendship_notifications.create(from_id: @user.id, status: :friendship_pending)
        end
        redirect_to friends_path
    end
    
    def update
        @user = current_user
        @requested_friend = User.find_by(id: params[:id])
        if @requested_friend and not @user.friends_with?(@requested_friend)
            @user.accept_request(@requested_friend)
            @requested_friend.friendship_notifications.create(from_id: @user.id, status: :friendship_accepted)
        end
        redirect_to friends_path
    end

    def destroy 
        @user = current_user
        @requested_friend = User.find_by(id: params[:id])
        if @requested_friend and @user.friends_with?(@requested_friend)
            @user.remove_friend(@requested_friend)
        end
        redirect_to friends_path
    end
end
