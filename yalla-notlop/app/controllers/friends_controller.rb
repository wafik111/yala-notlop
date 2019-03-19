class FriendsController < ApplicationController
    before_action :get_user
    before_action :get_requested_friend, except: [:index, :create]
    def index
        @friends = @user.friends.order("friendships.created_at DESC")
        @requested_friends = @user.requested_friends.order("friendships.created_at DESC")
        @pending_friends = @user.pending_friends.order("friendships.created_at DESC")
    end

    def create
        @requested_friend = User.find_by(name: params[:name])
        if @requested_friend and not @user.friends_with?(@requested_friend)
            @user.friend_request(@requested_friend)
            @requested_friend.friendship_notifications.create(from_id: @user.id, status: :unread, notification_type: :friendship_pending)
        end
        redirect_to friends_path
    end
    
    #PUT /friends/:id
    def update
        if @requested_friend and not @user.friends_with?(@requested_friend)
            @user.accept_request(@requested_friend)
            @requested_friend.friendship_notifications.create(from_id: @user.id, status: :unread, notification_type: :friendship_accepted)
        end
        redirect_to friends_path
    end

    def destroy 
        if @requested_friend and @user.friends_with?(@requested_friend)
            @user.remove_friend(@requested_friend)
        end
        redirect_to friends_path
    end

    #GET /friends/:id/cancel
    def cancel
        @user.decline_request(@requested_friend)
        redirect_to friends_path
    end
    private

    def get_user
        @user = current_user
    end

    def get_requested_friend
        @requested_friend = User.find_by(id: params[:id])
    end
end
