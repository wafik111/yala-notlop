class OrderNotificationsController < ApplicationController

    #GET /invitation/:id/accept
    def accept
        @user = current_user
        @notification = @user.order_notifications.find_by(id: params[:id])
        if @notification
            @notification.update(type: :invitation_accepted) if @notification.invitation_accepted?
        @invitation = @user.invited_members
    end
end
