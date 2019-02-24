class InvitedMembersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @order = Order.find_by(id: params[:order_id])
        @invited_members = @order.invited_members.joins(:user).select(:name, :email, :id)
    end

    #POST /orders/invite.json
    def invite
        @user = User.find_by(name: params[:name])
        if @user
            render json: [@user].to_json(only: [:id, :email, :name]) and return
        end
        @group = current_user.groups.find_by(name: params[:name])
        if @group
            @members = @group.members.joins(:user).select("name, email, user_id as id")
            render :json => @members.to_json(only: [:id, :name, :email]) and return
        end
        render json: [].to_json() and return
    end
end
