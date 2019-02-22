class InvitedMembersController < ApplicationController
    def index
        @order = Order.find_by(id: params[:id])
        @invited_members = @order.invited_members.joins(:user).select(:name, :email, :id)
    end
end
